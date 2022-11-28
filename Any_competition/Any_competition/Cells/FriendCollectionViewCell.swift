//
//  FriendCollectionViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 28.11.2022.
//

import UIKit
import SnapKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .anyGreenColor
        image.image = UIImage(named: "userPhoto")
        image.contentMode = .scaleAspectFill
        image.tintColor = .anyDarckColor
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel = AnyCompUILabel(title: "John Doe", fontSize: .medium)
    
    let nickLabel = AnyCompUILabel(title: "Some nick", fontSize: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 32
        setupCell()
        setupProperts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(photoView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nickLabel)
        
        let inset: CGFloat = 16
        
        photoView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(contentView).inset(inset)
            make.width.equalTo(photoView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoView.snp.trailing).offset(inset)
            make.centerY.equalTo(contentView)
        }
        
        nickLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(inset)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func setupProperts() {
        nickLabel.textAlignment = .right
        nameLabel.textAlignment = .left
    }
    
    func setupCellData(player: User) {
        nameLabel.text = player.firstName + " " + player.lastName
        nickLabel.text = player.nick
    }
    
}
