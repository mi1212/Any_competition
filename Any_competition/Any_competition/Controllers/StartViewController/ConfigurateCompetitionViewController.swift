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
    
    let database = Database()
    
    var competitionTitle: String?
    
    var playerQty: Int?
    
    var sportType: String?
    
    var playersArray: [Player] = []
    
    var id = ""
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "ошибка", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
    
    weak var delegate: ConfigurateCompetitionViewControllerDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isExclusiveTouch = true
        scroll.isUserInteractionEnabled = true
        scroll.canCancelContentTouches = true
        scroll.delaysContentTouches = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    let cellHeight: CGFloat = 52*3.8
    
    private lazy var playersTableView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(PlayerDataCollectionViewCell.self, forCellWithReuseIdentifier: PlayerDataCollectionViewCell.identifire)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let addButton = AnyCompUIButton(title: "Готово")
    
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
            playersTableView.heightAnchor.constraint(equalToConstant: ((cellHeight+12)*CGFloat(playerQty!)-12))
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
    
        let info = Info(title: competitionTitle!, qtyPlayers: playerQty!, date: Date.now.description)
        
        if let user = ProfileViewController.user {
            
            let accessUserArray = [user]
            
            let competition = Competition(info: info, players: playersArray, accessUserArray: accessUserArray)
            
            database.sendCompetitionToDatabase(competition: competition)
            
            dismiss(animated: true, completion: nil)
            
            delegate?.dismissController()
        } else {
            alert.message = "необходимо авторизоваться"
            self.present(alert, animated: true)
        }
        
        
    }
}

extension ConfigurateCompetitionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playerQty!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerDataCollectionViewCell.identifire, for: indexPath) as! PlayerDataCollectionViewCell
        cell.label.text! += "\(indexPath.row+1)"
        return cell
    }
    
    
}

extension ConfigurateCompetitionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.layer.bounds.width
        
        let size = CGSize(width: width, height: cellHeight)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath) as! PlayerDataCollectionViewCell
        
        let alert = UIAlertController(title: "Введите данные игрока", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Имя"
            nameTextField.text = cell.nameLabel.text
        }
        
        alert.addTextField { (secondNameTextField) in
            secondNameTextField.placeholder = "Фамилия"
            secondNameTextField.text = cell.secondNameLabel.text
        }
        
        alert.addTextField { (nickTextField) in
            nickTextField.placeholder = "Ник"
            nickTextField.text = cell.nickLabel.text
        }
        
        alert.addAction(UIAlertAction(title: "Выйти", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Применить", style: .default, handler: { [self] _ in
            cell.nameLabel.text = alert.textFields![0].text
            cell.secondNameLabel.text = alert.textFields![1].text
            cell.nickLabel.text = alert.textFields![2].text

            let player = Player(number: indexPath.row, name: cell.nameLabel.text!, secondName: cell.secondNameLabel.text!, nick: cell.nickLabel.text!)

            let index = indexPath.row
            
            if playersArray.count - 1 < index {
                playersArray.insert(player, at: indexPath.row)
            } else {
                playersArray[index] = player
            }
        }))
        
        
        
        self.present(alert, animated: true, completion: nil)
    }
}
