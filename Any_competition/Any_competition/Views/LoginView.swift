//
//  LoginView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func disappeare() 
}

class LoginView: UIView {
    
    var delegate: LoginViewDelegate?
    
    // MARK: UIViews
    
    let label = AnyCompLogoUILabel()
    
    let mailTextField = AnyCompUITextField(placeholder: "введите почту", isSecure: false)
    
    let passTextField = AnyCompUITextField(placeholder: "введите пароль", isSecure: true)
    
    let loginButton = AnyCompUIButton(title: "Войти")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .anyColor1
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        self.layer.cornerRadius = 24
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(label)
        label.text = "Пожалуйста авторизуйтесь"
        self.addSubview(mailTextField)
        self.addSubview(passTextField)
        self.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            mailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            mailTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -inset),
            mailTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            passTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            passTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            passTextField.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: inset),
            passTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            loginButton.heightAnchor.constraint(equalToConstant: 64),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset)
        ])
    }
    
    @objc func tapLoginButton() {
        delegate?.disappeare()
    }
    
}
