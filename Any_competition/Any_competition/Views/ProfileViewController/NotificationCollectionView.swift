//
//  NotificationCollectionView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 01.12.2022.
//

import UIKit
import SnapKit

protocol NotificationCollectionViewDelegate: AnyObject {
    func tapAddFriendButton()
    func tapFriendButton()
    func tapToCell(user: User)
}

class NotificationCollectionView: UIView {
    
    let userDefaults = UserDefaults.standard
    
    weak var delegate: NotificationCollectionViewDelegate?
    
    var isCollectionViewFull: Bool?
    
    // MARK: - UIViews
    
    var user: User? {
        didSet {
//            self.layoutIfNeeded()
        }
    }

    lazy var notificationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collection.backgroundColor = .clear
//        collection.isScrollEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: FriendCollectionViewCell.identifire)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
//    convenience init() {
//        self.init()
//        
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNotificationCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNotificationCollectionView() {
        self.addSubview(notificationCollectionView)
        
        notificationCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension NotificationCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.identifire, for: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.identifire, for: indexPath) as! FriendCollectionViewCell
//        cell.backgroundColor = .white
        switch indexPath.row % 2 {
        case 0: cell.contentView.backgroundColor = .anyGreenColor
        case 1: cell.contentView.backgroundColor = .anyDarckColor
        default:
            cell.backgroundColor = .anyGreenColor
        }
        
        return cell
    }
 
}

extension NotificationCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
        let inset = 16
        let width = (Int(self.bounds.width) - inset*2)/1
        let height = (Int(self.bounds.height) - inset*6)/7
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.tapToCell(user: User(firstName: "a", lastName: "sdfsd", nick: "sdfsdf"))
    }
}

