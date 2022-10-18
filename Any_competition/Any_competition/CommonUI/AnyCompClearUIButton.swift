//
//  AnyCompClearUIButton.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 18.10.2022.
//

import UIKit

class AnyCompClearUIButton: UIButton {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
        self.titleLabel?.font =  UIFont.systemFont(ofSize: UIFont.buttonFontSize, weight: .regular)
        self.setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

