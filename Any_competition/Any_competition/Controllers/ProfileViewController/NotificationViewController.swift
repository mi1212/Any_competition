//
//  NotificationViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 16.11.2022.
//

import UIKit
import SnapKit

class NotificationViewController: UIViewController {

    let label = AnyCompLogoUILabel()
    
    let notificationCollectionView = NotificationCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(label)
        self.view.addSubview(notificationCollectionView)
        label.text = "Уведомления"
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        notificationCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(label.snp.bottom).inset(-16)
        }
    }

}
