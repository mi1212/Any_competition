//
//  PlayersInfoTableViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 23.09.2022.
//

import UIKit

class PlayersInfoTableViewCell: UITableViewCell {
    
    let numberLabel = AnyCompUILabel(title: "#", fontSize: .medium)
    
    let nameLabel = AnyCompUILabel(title: "", fontSize: .medium)
    
    let secondNameLabel = AnyCompUILabel(title: "", fontSize: .medium)
    
    let emailLabel = AnyCompUILabel(title: "", fontSize: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        self.setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupCell() {
        self.contentView.addSubview(numberLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(secondNameLabel)
        self.contentView.addSubview(emailLabel)
        
        let inset: CGFloat = 5
        
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            numberLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: inset),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            secondNameLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: inset),
            secondNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: inset),
            secondNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            emailLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
