//
//  ProfileView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 18.10.2022.
//

import UIKit

class ProfileView: UIView {
    
    let label = AnyCompLogoUILabel()
    
    let nickLabel = AnyCompUILabel(title: "", fontSize: .large)
    
    let firstNameLabel = AnyCompUILabel(title: "", fontSize: .medium)
    
    let lastNameLabel = AnyCompUILabel(title: "", fontSize: .medium)
    
    let idLabel = AnyCompUILabel(title: "", fontSize: .small)
    
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
        self.addSubview(label)
        self.addSubview(nickLabel)
        nickLabel.textAlignment = .left
        self.addSubview(firstNameLabel)
        firstNameLabel.textAlignment = .left
        self.addSubview(lastNameLabel)
        lastNameLabel.textAlignment = .left
        self.addSubview(idLabel)
        idLabel.textAlignment = .left
        label.textAlignment = .center
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset*2),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            nickLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            nickLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            nickLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            firstNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            firstNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            firstNameLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            lastNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            lastNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset*2),
            idLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            idLabel.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: inset*2),
        ])
    }
    
    func setupData(nick: String, firstName: String, lastName: String, id: String) {
        nickLabel.text = nick
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        idLabel.text = id
    }
    
}
