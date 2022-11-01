//
//  AddPlayerView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 01.11.2022.
//

import UIKit

protocol AddPlayerViewDelegate: AnyObject {
    func tapAddButton(player: Player)
    
    func tapCancelButton()
}

class AddPlayerView: UIView {
    
    var delegate: AddPlayerViewDelegate?
    
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
    
    
    
    let addButton = AnyCompUIButton(title: "Добавить")
    
    let cancelButton = AnyCompUIButton(title: "Выйти")
    
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
        label.text = "Игрок"
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(nickNameTextField)
        contentView.addSubview(addButton)
        contentView.addSubview(cancelButton)

        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
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
            firstNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: inset),
            lastNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: inset),
            nickNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            nickNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: inset),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2),
            addButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: inset),
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor),
            cancelButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2),
            cancelButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
        ])
    }
    
    func clearTextFields() {
        let textFieldArray = [firstNameTextField, lastNameTextField, nickNameTextField]
        
        textFieldArray.map {
            $0.text = ""
            $0.backgroundColor = .white
            
        }
    }
    
    @objc func tapAddButton() {
        animationTapButton(addButton)
        
        guard let firstName = firstNameTextField.text else {return}
        
        guard let lastName = lastNameTextField.text else {return}
        
        guard let nick = nickNameTextField.text else {return}
        
        let textFieldArray = [firstNameTextField, lastNameTextField, nickNameTextField]
        
        if firstName != "" && lastName != "" && nick != "" {
            let player = Player(firstName: firstName, lastName: lastName, nick: nick)
            
            delegate?.tapAddButton(player: player)
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
