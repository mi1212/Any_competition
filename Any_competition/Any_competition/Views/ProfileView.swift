//
//  ProfileView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 18.10.2022.
//

import UIKit

class ProfileView: UIView {
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .anyColor1
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        self.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(nickLabel)
        nickLabel.textAlignment = .left
        contentView.addSubview(firstNameLabel)
        firstNameLabel.textAlignment = .left
        contentView.addSubview(lastNameLabel)
        lastNameLabel.textAlignment = .left
        contentView.addSubview(idLabel)
        idLabel.textAlignment = .left
        label.textAlignment = .center
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
            nickLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            nickLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nickLabel.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: inset*2),
        ])
  
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset*2),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            idLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset*2),
        ])
    }
    
    func setupData(nick: String, firstName: String, lastName: String, id: String) {
        nickLabel.text = nick
        firstNameLabel.text = firstName
        lastNameLabel.text = lastName
        idLabel.text = id
    }
    
}
