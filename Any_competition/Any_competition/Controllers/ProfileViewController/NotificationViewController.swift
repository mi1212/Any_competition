//
//  NotificationViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.12.2022.
//

import UIKit
import SnapKit

class NotificationViewController: UIViewController {
    
    let database = Database()

    let acceptButton = AnyCompUIButton(title: "принять")
    
    let declineButton = AnyCompUIButton(title: "отклонить")
    
    var requestingUser: User?
    
    var hostUser: User?
    
    convenience init(hostUser: User, requestingUser: User) {
        self.init()
        self.requestingUser = requestingUser
        self.hostUser = hostUser
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        declineButton.backgroundColor = .systemPink
        setupLayout()
        setupTargetsButtons()
    }

    private func setupLayout() {
        self.view.addSubview(acceptButton)
        self.view.addSubview(declineButton)
        
        let inset = 16
        
        acceptButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(64)
        }
        
        declineButton.snp.makeConstraints { make in
            make.top.equalTo(acceptButton.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(64)
        }
    }
    
    private func setupTargetsButtons() {
        acceptButton.addTarget(self, action: #selector(tapAcceptButton), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(tapDeclineButton), for: .touchUpInside)
    }
    
    @objc func tapAcceptButton() {
        print("tapAcceptButton")
        if let requestingUser = requestingUser, let receivingUser = hostUser {
            database.acceptFriendRequesr(requestingUser: requestingUser, receivingUser: receivingUser)
        }
    }
    
    @objc func tapDeclineButton() {
        print("tapDeclineButton")
    }
    
}
