//
//  NotificationCollectionViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 01.12.2022.
//

import UIKit
import SnapKit

class NotificationCollectionViewCell: UICollectionViewCell {
    
    var nameLabel = AnyCompUILabel(title: "John Doe", fontSize: .medium)
    
    var dateLabel = AnyCompUILabel(title: "Some nick", fontSize: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 32
        self.backgroundColor = .anyGreenColor
        setupCell()
        setupProperts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(dateLabel)
        
        let inset: CGFloat = 16

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(inset)
            make.centerY.equalTo(contentView)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(inset)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func setupProperts() {
        dateLabel.textAlignment = .right
        nameLabel.textAlignment = .left
    }
    
    func setupCellData(notification: AddFriendNotification) {
        nameLabel.text = notification.userFriend.firstName + " " + notification.userFriend.lastName
        dateLabel.text = notification.date
    }
    
}
