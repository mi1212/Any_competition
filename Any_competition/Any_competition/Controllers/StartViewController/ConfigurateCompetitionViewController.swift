//
//  ConfigurateCompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 23.09.2022.
//

import UIKit
import FirebaseFirestore

protocol ConfigurateCompetitionViewControllerDelegate: AnyObject {
    func dismissController()
}

class ConfigurateCompetitionViewController: UIViewController {
    
    var db = Firestore.firestore()
    
    var competitionTitle: String?
    
    var playerQty: Int?
    
    var sportType: String?
    
    var playersArray: [Player] = []
    
    var id = ""
    
    weak var delegate: ConfigurateCompetitionViewControllerDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private lazy var playersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .purple
        tableView.insetsContentViewsToSafeArea = true
        tableView.register(PlayersInfoTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let addButton = AnyCompUIButton(title: "Завершить создание")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupController()
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
    }
    
    private func setupController() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(playersTableView)
        contentView.addSubview(addButton)
        
        let inset: CGFloat = 30
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
 
        NSLayoutConstraint.activate([
            playersTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset/2),
            playersTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            playersTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            playersTableView.heightAnchor.constraint(equalToConstant: 60*CGFloat(playerQty!))
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: playersTableView.bottomAnchor, constant: inset/2),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            addButton.heightAnchor.constraint(equalToConstant: 64),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc func tapAddButton() {
        
        var ref: DocumentReference? = nil
        
        let players = playersArray.map{ $0.dictionary }
        
        let info = Info(title: competitionTitle!, qtyPlayers: playerQty!, sportType: sportType!, date: Date.now.description)
 
        ref = db.collection("competitions").addDocument(data: [
            "info" : info.dictionary,
            "players" : players
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.id = ref!.documentID
                print("Document added with ID: \(ref!.documentID)")
            }
        }

        
        //
        
        print("\(db.collection("competitions"))")
        
        dismiss(animated: true, completion: nil)

        dismiss(animated: true, completion: nil)
        delegate?.dismissController()
    }
}

extension ConfigurateCompetitionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        playerQty!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayersInfoTableViewCell
        cell.numberLabel.text! += "\(indexPath.row+1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! PlayersInfoTableViewCell
        
        let alert = UIAlertController(title: "Введите данные игрока", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Имя"
            nameTextField.text = cell.nameLabel.text
        }
        
        alert.addTextField { (secondNameTextField) in
            secondNameTextField.placeholder = "Фамилия"
            secondNameTextField.text = cell.secondNameLabel.text
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
            cell.nameLabel.text = alert?.textFields![0].text
            cell.secondNameLabel.text = alert?.textFields![1].text
            
            
            playersArray.insert(Player(name: cell.nameLabel.text!, secondName: cell.secondNameLabel.text!), at: indexPath.row)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ConfigurateCompetitionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    
    
}
