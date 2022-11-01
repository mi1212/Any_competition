//
//  playersTableCollectionViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 01.11.2022.
//

import UIKit

class playersTableCollectionViewCell: UICollectionViewCell {
        
    let nameLabel = AnyCompUILabel(title: "", fontSize: .medium)
    let nickLabel = AnyCompUILabel(title: "", fontSize: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.borderWidth = 2
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(nickLabel)
        
        let inset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([

            nickLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nickLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }
    
    func setupCellData(player: Player) {
        nameLabel.text = player.firstName + " " + player.lastName
        nickLabel.text = player.nick
    }
    
}
