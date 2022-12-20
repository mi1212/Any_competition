//
//  NotificationViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 16.11.2022.
//

import UIKit
import SnapKit

class NotificationsViewController: UIViewController {
    
    var hostUser: User?

    let label = AnyCompLogoUILabel()
    
    var notificationCollectionView: NotificationCollectionView?
    
    convenience init(hostUser: User) {
        self.init()
        self.hostUser = hostUser
        notificationCollectionView = NotificationCollectionView(notifications: hostUser.notificationArray)
        notificationCollectionView?.delegate = self
        self.view.backgroundColor = .backgroundColor
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupViews() {
        self.view.addSubview(label)
        self.view.addSubview(notificationCollectionView!)
        label.text = "Уведомления"
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        notificationCollectionView!.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(label.snp.bottom).inset(-16)
        }
    }

}

extension NotificationsViewController: NotificationCollectionViewDelegate {
    func tapAddFriendButton() {
        
    }
    
    func tapFriendButton() {
        
    }
    
    func tapToCell(user: User) {
        let vc = NotificationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
