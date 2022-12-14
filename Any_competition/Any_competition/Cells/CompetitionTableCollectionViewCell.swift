//
//  CompetitionTableCollectionViewCell.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 02.10.2022.
//

import UIKit

class CompetitionTableCollectionViewCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: UIFont.systemFontSize)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.borderWidth = 1
        setupCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .white
        self.label.text = ""
    }
    
    private func setupCell() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -5),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

