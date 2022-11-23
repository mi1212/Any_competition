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
    
    var user: User? {
        didSet {
            setupUserData(user: user!)
        }
    }
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let nickLabel = AnyCompLogoUILabel()
    
    let firstNameLabel = AnyCompUILabel(title: "Имя: ", fontSize: .medium)
    
    let lastNameLabel = AnyCompUILabel(title: "Фамилия: ", fontSize: .medium)
    
    let playedGamesLabel = AnyCompUILabel(title: "Игры: ", fontSize: .medium)
    
    let wonGamesLabel = AnyCompUILabel(title: "Победы: ", fontSize: .medium)
    
    let lostGamesLabel = AnyCompUILabel(title: "Поражения: ", fontSize: .medium)

    let wonCupsLabel = AnyCompUILabel(title: "Кубки: ", fontSize: .medium)
    
    let friendsView = FriendsCollectionView()

    let exitButton = AnyCompClearUIButton(title: "Выйти из профиля")
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .anyGreenColor
        image.image = UIImage(systemName: "person")
        image.tintColor = .anyDarckColor
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(nickLabel)
        
        self.addSubview(imageView)
        self.addSubview(nameStackView)
        nameStackView.addArrangedSubview(firstNameLabel)
        nameStackView.addArrangedSubview(lastNameLabel)
        
        self.addSubview(stackView)
        stackView.addArrangedSubview(playedGamesLabel)
        stackView.addArrangedSubview(wonGamesLabel)
        stackView.addArrangedSubview(lostGamesLabel)
        stackView.addArrangedSubview(wonCupsLabel)
        
        self.addSubview(friendsView)
        
        self.addSubview(exitButton)
        
        exitButton.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        
        firstNameLabel.textAlignment = .left
        lastNameLabel.textAlignment = .left
        nickLabel.textAlignment = .center
        
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            nickLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset*2),
            nickLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            nickLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: nameStackView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset),
            nameStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: inset),
            nameStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            nameStackView.heightAnchor.constraint(equalToConstant: inset*5)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: inset),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            stackView.heightAnchor.constraint(equalToConstant: inset*6)
        ])
        
        NSLayoutConstraint.activate([
            friendsView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: inset),
            friendsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            friendsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            friendsView.heightAnchor.constraint(equalToConstant: inset*10)
        ])
        
        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            exitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset*2),
        ])
    }
    
    func setupUserData(user: User) {
        nickLabel.text = user.nick
        firstNameLabel.text! = user.firstName
        lastNameLabel.text! = user.lastName
        playedGamesLabel.text! = "Игры: \(user.playedGames)"
        wonGamesLabel.text! = "Победы: \(user.wonGames)"
        lostGamesLabel.text! = "Поражения: \(user.lostGames)"
        wonCupsLabel.text! = "Кубки: \(user.wonCups)"
    }
    
    @objc func tapExitButton() {
        delegate?.exitFromProfileView()
    }
    
}
