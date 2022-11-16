//
//  AnyCompUITextField.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit

class AnyCompUITextField: UITextField {
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(placeholder: String, isSecure: Bool) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 2))
        self.leftView = leftView
        self.leftViewMode = .always
        self.rightView = rightView
        self.rightViewMode = .always
        self.autocapitalizationType = .none
        self.tintColor = .black
        self.textColor = .black
        self.adjustsFontForContentSizeCategory = true
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.clearButtonMode = .whileEditing
        translatesAutoresizingMaskIntoConstraints = false
    }
}
