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
    
    let resetPassButton = AnyCompClearUIButton(title: "сбросить пароль")
    
    let createUserButton = AnyCompClearUIButton(title: "создать учетную запись")
    
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
        contentView.addSubview(resetPassButton)
        contentView.addSubview(createUserButton)
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        createUserButton.addTarget(self, action: #selector(tapCreateUserButton), for: .touchUpInside)
        resetPassButton.addTarget(self, action: #selector(tapResetPassButton), for: .touchUpInside)
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
            resetPassButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: inset),
            resetPassButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resetPassButton.bottomAnchor.constraint(greaterThanOrEqualTo: createUserButton.topAnchor, constant: -3*inset)
        ])
        
        NSLayoutConstraint.activate([
            createUserButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createUserButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
    
    @objc func tapLoginButton() {
        delegate?.tapLogin()
        animationTapButton(loginButton)
    }
    
    
    @objc func tapCreateUserButton() {
        delegate?.tapStartCreateUser()
        animationTapButton(createUserButton)
    }
    
    @objc func tapResetPassButton() {
        delegate?.tapResetPassword()
        animationTapButton(resetPassButton)
    }
}
