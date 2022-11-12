//
//  SearchTableViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 12.11.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    let firstNameLabel = AnyCompUILabel(title: "", fontSize: .small)
    
    let lastNameLabel = AnyCompUILabel(title: "", fontSize: .small)
    
    let nickNameLabel = AnyCompUILabel(title: "", fontSize: .small)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        self.setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    private func setupCell() {
        self.contentView.addSubview(firstNameLabel)
        self.contentView.addSubview(lastNameLabel)
        self.contentView.addSubview(nickNameLabel)
        
        let inset: CGFloat = 5

        
        NSLayoutConstraint.activate([
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            firstNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
        ])
        
        NSLayoutConstraint.activate([
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: inset),
        ])
        
        NSLayoutConstraint.activate([
            nickNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nickNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func setupCell(firstName: String, lastName: String, nickName: String){
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        nickNameLabel.text = nickName
    }

}
