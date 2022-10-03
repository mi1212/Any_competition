//
//  CompetitionTableCollectionViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 02.10.2022.
//

import UIKit

class CompetitionTableCollectionViewCell: UICollectionViewCell {
    
    let label = AnyCompUILabel(title: "", fontSize: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(label)
        label.numberOfLines = 0
        contentView.layer.borderColor = UIColor.anyDarckColor.cgColor
        contentView.layer.borderWidth = 1
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -5),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

