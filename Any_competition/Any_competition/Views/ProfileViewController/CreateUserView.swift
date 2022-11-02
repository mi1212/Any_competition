//
//  CreateUserView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 19.10.2022.
//

import UIKit

protocol CreateUserViewDelegate: AnyObject {
    func tapCreateUser(firstName: String, lastName: String, nickName: String, mail: String, pass: String)
    func tapCancelButton()
}

class CreateUserView: UIView {
    
    var delegate: CreateUserViewDelegate?
    
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
    
    let firstNameTextField = AnyCompUITextField(placeholder: "Имя", isSecure: false)
    
    let lastNameTextField = AnyCompUITextField(placeholder: "Фамилия", isSecure: false)
    
    let nickNameTextField = AnyCompUITextField(placeholder: "Ник в игре", isSecure: false)
    
    let mailTextField = AnyCompUITextField(placeholder: "Почта", isSecure: false)
    
    let passTextField = AnyCompUITextField(placeholder: "Пароль", isSecure: true)
    
    let createButton = AnyCompUIButton(title: "Создать")
    
    let cancelButton = AnyCompClearUIButton(title: "Вернуться назад")
    
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
        label.text = "Создать аккаунт"
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(nickNameTextField)
        contentView.addSubview(mailTextField)
        contentView.addSubview(passTextField)
        contentView.addSubview(createButton)
        contentView.addSubview(cancelButton)

        createButton.addTarget(self, action: #selector(tapCreateButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        
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
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
        ])
        
        NSLayoutConstraint.activate([
            firstNameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            firstNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            firstNameTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: inset),
            lastNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            lastNameTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: inset),
            nickNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            nickNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nickNameTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            mailTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: inset),
            mailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            mailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            mailTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: inset),
            passTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            passTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            passTextField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: inset),
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            createButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: inset),
            cancelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cancelButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
        ])
    }
    
    @objc func tapCreateButton() {
        animationTapButton(createButton)
        guard let firstName = firstNameTextField.text else {return}
        guard let lastName = lastNameTextField.text else {return}
        guard let nick = nickNameTextField.text else {return}
        guard let mail = mailTextField.text else {return}
        guard let pass = passTextField.text else {return}
        
        let textFieldArray = [firstNameTextField, lastNameTextField, nickNameTextField, mailTextField, passTextField]
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
    
    @objc func tapCancelButton() {
        animationTapButton(cancelButton)
        delegate?.tapCancelButton()
        
    }
 
}
