//
//  CreateUserView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 19.10.2022.
//

import UIKit

//protocol CreatePlayerViewDelegate: AnyObject {
//    func disappeare()
//}

class CreateUserView: UIView {
    
//    var delegate: LoginViewDelegate?
    
    // MARK: UIViews
    
    let label = AnyCompLogoUILabel()
    
    let firstNameTextField = AnyCompUITextField(placeholder: "Имя", isSecure: false)
    
    let lastNameTextField = AnyCompUITextField(placeholder: "Фамилия", isSecure: false)
    
    let mailTextField = AnyCompUITextField(placeholder: "Почта", isSecure: false)
    
    let passTextField = AnyCompUITextField(placeholder: "Пароль", isSecure: true)
    
    let createButton = AnyCompUIButton(title: "Создать")
//
//    let resetPass = AnyCompClearUIButton(title: "сбросить пароль")
//
//    let createUser = AnyCompClearUIButton(title: "создать учетную запись")
    
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
        label.text = "Создать аккаунт"
        self.addSubview(firstNameTextField)
        self.addSubview(lastNameTextField)
        self.addSubview(mailTextField)
        self.addSubview(passTextField)
        self.addSubview(createButton)
//        self.addSubview(resetPass)
//        self.addSubview(createUser)
        createButton.addTarget(self, action: #selector(tapCreateButton), for: .touchUpInside)
//        createUser.addTarget(self, action: #selector(tapCreateUserButton), for: .touchUpInside)
//        resetPass.addTarget(self, action: #selector(tapResetPassButton), for: .touchUpInside)
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 3*inset),
            firstNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            firstNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            mailTextField.heightAnchor.constraint(equalToConstant: self.layer.bounds.height/7)
            firstNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: self.firstNameTextField.bottomAnchor, constant: inset),
            lastNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            lastNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            passTextField.heightAnchor.constraint(equalToConstant: self.layer.bounds.height/7)
            lastNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: inset),
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
        
//
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: inset),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            createButton.heightAnchor.constraint(equalToConstant: 64),
        ])
//
//        NSLayoutConstraint.activate([
//            resetPass.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: inset),
//            resetPass.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
//            resetPass.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
////            createUser.heightAnchor.constraint(equalToConstant: 64),
//            resetPass.bottomAnchor.constraint(greaterThanOrEqualTo: createUser.topAnchor, constant: -3*inset)
//        ])
//
//        NSLayoutConstraint.activate([
////            createUser.topAnchor.constraint(equalTo: resetPass.bottomAnchor, constant: inset/2),
//            createUser.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
//            createUser.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
////            createUser.heightAnchor.constraint(equalToConstant: 64),
//            createUser.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset)
//        ])
    }
    
    @objc func tapCreateButton() {
//        delegate?.disappeare()
        print("tapCreateUserButton")
    }
    
    
    @objc func tapCreateUserButton() {
        print("tapCreateUserButton")
    }
    
    @objc func tapResetPassButton() {
        print("tapResetPassButton")
    }
}
