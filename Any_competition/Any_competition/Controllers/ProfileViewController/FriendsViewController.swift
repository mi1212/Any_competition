//
//  FriendsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 29.11.2022.
//

import UIKit
import SnapKit

class FriendsViewController: UIViewController {

    var hostUser: User? {
        didSet {
            
        }
    }
    
    let friendsView = FriendsCollectionView(isCollectionViewFull: true, isWithAddFriendButton: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
    
        self.view.addSubview(friendsView)
        friendsView.backgroundColor = .blue
        self.friendsView.delegate = self
        friendsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension FriendsViewController: FriendsCollectionViewDelegate {
    func tapToCell(user: User) {
        if let hostUser = hostUser {
            let vc = FriendViewController(hostUser: hostUser, choosedUser: user)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tapAddFriendButton() {
        
    }
    
    func tapFriendButton() {
        
    }
    
}
