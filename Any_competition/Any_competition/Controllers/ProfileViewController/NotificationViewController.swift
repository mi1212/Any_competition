//
//  NotificationViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.12.2022.
//

import UIKit
import SnapKit

class NotificationViewController: UIViewController {

    let acceptButton = AnyCompUIButton(title: "принять")
    
    let declineButton = AnyCompUIButton(title: "отклонить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        declineButton.backgroundColor = .systemPink
        setupLayout()
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
    
}
