//
//  CreateUserView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 19.10.2022.
//

import UIKit

protocol CreateUserViewDelegate: AnyObject {
    func tapCreateUser(firstName: String, lastName: String, nickName: String, mail: String, pass: String)
}

class CreateUserView: UIView {
    
    var delegate: CreateUserViewDelegate?
    
    // MARK: UIViews
    
    let label = AnyCompLogoUILabel()
    
//    let tempVar = 2
    
    let firstNameTextField = AnyCompUITextField(placeholder: "Имя", isSecure: false)
    
    let lastNameTextField = AnyCompUITextField(placeholder: "Фамилия", isSecure: false)
    
    let nickNameTextField = AnyCompUITextField(placeholder: "Ник в игре", isSecure: false)
    
    let mailTextField = AnyCompUITextField(placeholder: "Почта", isSecure: false)
    
    let passTextField = AnyCompUITextField(placeholder: "Пароль", isSecure: true)
    
    let createButton = AnyCompUIButton(title: "Создать")
    
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
        self.addSubview(nickNameTextField)
        self.addSubview(mailTextField)
        self.addSubview(passTextField)
        self.addSubview(createButton)

        createButton.addTarget(self, action: #selector(tapCreateButton), for: .touchUpInside)
        
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
            firstNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: self.firstNameTextField.bottomAnchor, constant: inset),
            lastNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            lastNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: self.lastNameTextField.bottomAnchor, constant: inset),
            nickNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            nickNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: inset),
            mailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            mailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            mailTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: self.mailTextField.bottomAnchor, constant: inset),
            passTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            passTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            passTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: inset),
            createButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            createButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            createButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
    
    @objc func tapCreateButton() {
        print("tapCreateButton")
        guard let firstName = firstNameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        guard let nick = nickNameTextField.text else {return}
        guard let mail = mailTextField.text else {return}
        guard let pass = passTextField.text else {return}
        
        let textFieldArray = [firstNameTextField, lastNameTextField, nickNameTextField, mailTextField, passTextField]
        print(tempVar)
        if firstName != "" && lastName != "" && nick != "" && mail != "" && pass != "" {
            delegate?.tapCreateUser(
                firstName: firstName,
                lastName: lastName,
                nickName: nick,
                mail: mail,
                pass: pass
            )
        } else {
            textFieldArray.map {
                shakeTextFieldifEmpty($0)
            }
            
        }
    }
 
}
