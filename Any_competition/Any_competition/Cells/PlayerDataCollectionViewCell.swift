//
//  PlayerDataCollectionViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 07.10.2022.
//

import UIKit

class PlayerDataCollectionViewCell: UICollectionViewCell {
    
    let label = AnyCompUILabel(title: "Данные игрока №", fontSize: .medium)
    
    private lazy var textFieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.layer.cornerRadius = 8
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 1
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nameLabel = AnyCompUITextField(placeholder: "Имя", isSecure: false)
    let secondNameLabel = AnyCompUITextField(placeholder: "Фамилия", isSecure: false)
    let nickLabel = AnyCompUITextField(placeholder: "Ник", isSecure: false)
    let fakeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(label)
        
        contentView.addSubview(textFieldsStackView)
        contentView.addSubview(fakeView)
        
        let textFieldsArray = [nameLabel ,secondNameLabel ,nickLabel ]
        textFieldsArray.map { $0.layer.cornerRadius = 0 }

        textFieldsStackView.addArrangedSubview(self.nameLabel)
        textFieldsStackView.addArrangedSubview(self.secondNameLabel)
        textFieldsStackView.addArrangedSubview(self.nickLabel)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: label.bottomAnchor),
            textFieldsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textFieldsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textFieldsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            fakeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            fakeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            fakeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            fakeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
