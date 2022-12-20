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
    func tapToCell(requestingUser: User)
}

class NotificationCollectionView: UIView {
    
    weak var delegate: NotificationCollectionViewDelegate?
    
    var notifications = [AddFriendNotification]() {
        didSet {
            self.notificationCollectionView.reloadData()
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
        collection.register(NotificationCollectionViewCell.self, forCellWithReuseIdentifier: NotificationCollectionViewCell.identifire)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    convenience init(notifications: [AddFriendNotification]) {
        self.init()
        self.notifications = notifications
        setupNotificationCollectionView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        self.notifications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCollectionViewCell.identifire, for: indexPath) as! NotificationCollectionViewCell
        let notification = notifications[indexPath.row]
        cell.setupCellData(notification: notification)
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
        let requestingUser = notifications[indexPath.row].userFriend
        delegate?.tapToCell(requestingUser: requestingUser)
    }
}

