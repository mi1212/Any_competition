//
//  AnyCompUITextField.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit

import UIKit

class AnyCompUITextField: UITextField {
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
//        guard let font = UIFont(name: "Press Start 2P", size: 12) else {
//            print("Something wrong with font")
//            return
//        }
//        self.font = font
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 2))
        self.leftView = leftView
        self.leftViewMode = .always
        self.autocapitalizationType = .none
        self.tintColor = .black
//        self.isSecureTextEntry = true
        self.textColor = .black
        self.adjustsFontForContentSizeCategory = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        translatesAutoresizingMaskIntoConstraints = false
    }
}
