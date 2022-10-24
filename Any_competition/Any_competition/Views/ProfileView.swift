//
//  ProfileView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 18.10.2022.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func exitFromProfileView()
}

class ProfileView: UIView {
    
    var delegate: ProfileViewDelegate?
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .anyColor1
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label = AnyCompLogoUILabel()
    
    let firstNameLabel = AnyCompUILabel(title: "", fontSize: .medium)
    
    let lastNameLabel = AnyCompUILabel(title: "", fontSize: .medium)

    let exitButton = AnyCompClearUIButton(title: "Выйти из профиля")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .anyColor1
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 24
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(exitButton)
        
        exitButton.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        
        firstNameLabel.textAlignment = .left
        lastNameLabel.textAlignment = .left
        label.textAlignment = .center
        
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset*2),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            firstNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            firstNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            firstNameLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            lastNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            exitButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            exitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset*2),
        ])
    }
    
    func setupData(nick: String, firstName: String, lastName: String) {
        label.text = nick
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
    }
    
    @objc func tapExitButton() {
        delegate?.exitFromProfileView()
    }
    
}
