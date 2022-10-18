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
    
    let resetPass = AnyCompClearUIButton(title: "сбросить пароль")
    
    let createUser = AnyCompClearUIButton(title: "создать учетную запись")
    
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
        self.addSubview(resetPass)
        self.addSubview(createUser)
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        createUser.addTarget(self, action: #selector(tapCreateUserButton), for: .touchUpInside)
        resetPass.addTarget(self, action: #selector(tapResetPassButton), for: .touchUpInside)
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3*inset),
            mailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            mailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            mailTextField.heightAnchor.constraint(equalToConstant: self.layer.bounds.height/7)
            mailTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: inset),
            passTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            passTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            passTextField.heightAnchor.constraint(equalToConstant: self.layer.bounds.height/7)
            passTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: inset),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            loginButton.heightAnchor.constraint(equalToConstant: 64),
        ])
        
        NSLayoutConstraint.activate([
            resetPass.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: inset),
            resetPass.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            resetPass.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            createUser.heightAnchor.constraint(equalToConstant: 64),
            resetPass.bottomAnchor.constraint(greaterThanOrEqualTo: createUser.topAnchor, constant: -3*inset)
        ])
        
        NSLayoutConstraint.activate([
//            createUser.topAnchor.constraint(equalTo: resetPass.bottomAnchor, constant: inset/2),
            createUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            createUser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            createUser.heightAnchor.constraint(equalToConstant: 64),
            createUser.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset)
        ])
    }
    
    @objc func tapLoginButton() {
        delegate?.disappeare()
    }
    
    
    @objc func tapCreateUserButton() {
        print("tapCreateUserButton")
    }
    
    @objc func tapResetPassButton() {
        print("tapResetPassButton")
    }
}
