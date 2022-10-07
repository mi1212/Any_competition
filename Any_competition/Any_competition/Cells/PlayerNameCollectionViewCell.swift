//
//  PlayerNameCollectionViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 07.10.2022.
//

import UIKit

class PlayerNameCollectionViewCell: UICollectionViewCell {
    
    let nameTextField = AnyCompUITextField(placeholder: "" , isSecure: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(nameTextField)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
