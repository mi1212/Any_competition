//
//  AnyCompUILabel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.09.2022.
//

import UIKit

class AnyCompUILabel: UILabel {
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(title: String) {
        super.init(frame: .zero)
        self.text = title
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        guard let font = UIFont(name: "Press Start 2P", size: 20) else {
            print("Something wrong with font")
            return
        }
        self.font = font
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 0
        self.textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
