//
//  playersTableCollectionView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 01.11.2022.
//

import UIKit

//protocol playersTableCollectionViewDelegate: AnyObject{
//    func pressCompetition(index: Int)
//}

class playersTableCollectionView: UIView {
    
//    weak var delegate: CompetitionsCollectionViewDelegate?
    
    var playersArray: [Player] = []
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .blue
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(playersTableCollectionViewCell.self, forCellWithReuseIdentifier: playersTableCollectionViewCell.identifire)
        return collection
    }()
    
//    init(playersArray: [Player]) {
//        self.init()
//        self.playersArray = playersArray
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
  
}

extension playersTableCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(self.bounds.width))
        return CGSize(width: width, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension playersTableCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playersArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: playersTableCollectionViewCell.identifire, for: indexPath) as! playersTableCollectionViewCell
        
        let player = playersArray[indexPath.row]
        
        cell.setupCellData(player: player)
        cell.backgroundColor = .white
//        switch indexPath.row % 2 {
//        case 0: cell.contentView.backgroundColor = .anyColor
//        case 1: cell.contentView.backgroundColor = .anyColor1
//        default:
//            cell.backgroundColor = .anyColor
//        }

        return cell
    }
}
