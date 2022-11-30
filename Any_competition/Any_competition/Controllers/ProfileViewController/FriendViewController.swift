//
//  FriendViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 29.11.2022.
//

import UIKit
import SnapKit

class FriendViewController: UIViewController {
    
    var hostUser: User?
    
    var choosedUser: User?
    
    let database = Database()
    
    private let decoder = JSONDecoder()
    
    private let notificationCentre = NotificationCenter.default
    
    // MARK: - Views
    
    let profileView = ProfileView(isWithAddFriendButton: false)
    
    // MARK: - viewDidLoad
    
    convenience init(hostUser: User, choosedUser: User) {
        self.init()
        self.hostUser = hostUser
        self.choosedUser = choosedUser
        setupViews()
        profileView.setupUserData(user: choosedUser)
    }
    
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        self.profileView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Navigation
    
    // установка вьюх если не нужно залогиниться
    private func setupViews() {
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom).inset(80)
        }
        
    }
}

extension FriendViewController: ProfileViewDelegate {
    func tapAddToFriendButton() {
        database.sendNotificationToAddToFriends(requestingUser: choosedUser!, hostUser: hostUser!)
    }
}
