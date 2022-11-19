//
//  UserViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.11.2022.
//

import UIKit

class UserViewController: UIViewController {

    let userProfileView = UserProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(userProfileView)
        self.userProfileView.delegate = self

        NSLayoutConstraint.activate([
            userProfileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            userProfileView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            userProfileView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            userProfileView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension UserViewController: UserProfileViewDelegate {
    func addToFriendsButton() {
        print("UserProfileViewDelegate")
    }
    
    
}
