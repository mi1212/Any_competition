//
//  NotificationViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 16.11.2022.
//

import UIKit

class NotificationViewController: UIViewController {

    let label = AnyCompLogoUILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(label)
        label.text = "Уведомления"
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

}
