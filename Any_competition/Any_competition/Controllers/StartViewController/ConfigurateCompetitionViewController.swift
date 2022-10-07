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
    
    let cellHeight: CGFloat = 52
    
    private lazy var playersTableView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.register(PlayerNameCollectionViewCell.self, forCellWithReuseIdentifier: PlayerNameCollectionViewCell.identifire)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
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

extension ConfigurateCompetitionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playerQty!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerNameCollectionViewCell.identifire, for: indexPath)
        
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
}
