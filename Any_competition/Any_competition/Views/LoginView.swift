//
//  LoginView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func tapLogin()
    
    func tapStartCreateUser()
    
    func tapResetPassword()
}

class LoginView: UIView {
    
    var delegate: LoginViewDelegate?
    
    // MARK: UIViews
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .anyColor1
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label = AnyCompLogoUILabel()
    
    let mailTextField = AnyCompUITextField(placeholder: "введите почту", isSecure: false)
    
    let passTextField = AnyCompUITextField(placeholder: "введите пароль", isSecure: true)
    
    let loginButton = AnyCompUIButton(title: "Войти")
    
    let resetPass = AnyCompClearUIButton(title: "сбросить пароль")
    
    let createUser = AnyCompClearUIButton(title: "создать учетную запись")
    
    convenience init(user: User, pass: String) {
        self.init()
        mailTextField.text = user.mail
        passTextField.text = pass
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(contentView)
        contentView.addSubview(label)
        label.text = "Пожалуйста авторизуйтесь"
        contentView.addSubview(mailTextField)
        contentView.addSubview(passTextField)
        contentView.addSubview(loginButton)
        contentView.addSubview(resetPass)
        contentView.addSubview(createUser)
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        createUser.addTarget(self, action: #selector(tapCreateUserButton), for: .touchUpInside)
        resetPass.addTarget(self, action: #selector(tapResetPassButton), for: .touchUpInside)
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3*inset),
            mailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            mailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            mailTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: inset),
            passTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            passTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            passTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: inset),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            loginButton.heightAnchor.constraint(equalToConstant: 64),
        ])
        
        NSLayoutConstraint.activate([
            resetPass.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: inset),
            resetPass.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resetPass.bottomAnchor.constraint(greaterThanOrEqualTo: createUser.topAnchor, constant: -3*inset)
        ])
        
        NSLayoutConstraint.activate([
            createUser.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createUser.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    @objc func tapLoginButton() {
        print("tapLoginButton")
        delegate?.tapLogin()
    }
    
    
    @objc func tapCreateUserButton() {
        print("tapCreateUserButton")
        delegate?.tapStartCreateUser()
    }
    
    @objc func tapResetPassButton() {
        print("tapResetPassButton")
        delegate?.tapResetPassword()
    }
}
