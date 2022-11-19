//
//  UserProfileView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.11.2022.
//

import UIKit

protocol UserProfileViewDelegate: AnyObject {
    func addToFriendsButton()
}

class UserProfileView: UIView {
    
    var delegate: UserProfileViewDelegate?
    
    var user: User? {
        didSet {
            setupData(user: user!)
        }
    }
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .anyColor1
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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

    let addToFriendsButton = AnyCompUIButton(title: "Добавить в друзья")
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .anyColor
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
        self.addSubview(contentView)
        contentView.addSubview(nickLabel)
        
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameStackView)
        nameStackView.addArrangedSubview(firstNameLabel)
        nameStackView.addArrangedSubview(lastNameLabel)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(playedGamesLabel)
        stackView.addArrangedSubview(wonGamesLabel)
        stackView.addArrangedSubview(lostGamesLabel)
        stackView.addArrangedSubview(wonCupsLabel)
        
        contentView.addSubview(friendsView)
        
        contentView.addSubview(addToFriendsButton)
        
        addToFriendsButton.addTarget(self, action: #selector(tapaddToFriendsButton), for: .touchUpInside)
        
        firstNameLabel.textAlignment = .left
        lastNameLabel.textAlignment = .left
        nickLabel.textAlignment = .center
        
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            nickLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset*2),
            nickLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nickLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset*2),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: nameStackView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset),
            nameStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: inset),
            nameStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            nameStackView.heightAnchor.constraint(equalToConstant: inset*5)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: inset),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            stackView.heightAnchor.constraint(equalToConstant: inset*6)
        ])
        
        NSLayoutConstraint.activate([
            friendsView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: inset),
            friendsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            friendsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            friendsView.heightAnchor.constraint(equalToConstant: inset*10)
        ])
        
        NSLayoutConstraint.activate([
            addToFriendsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            addToFriendsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            addToFriendsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset*2),
            addToFriendsButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    func setupData(user: User) {
        nickLabel.text = user.nick
        firstNameLabel.text! = user.firstName
        lastNameLabel.text! = user.lastName
        playedGamesLabel.text! = "Игры: \(user.playedGames)"
        wonGamesLabel.text! = "Победы: \(user.wonGames)"
        lostGamesLabel.text! = "Поражения: \(user.lostGames)"
        wonCupsLabel.text! = "Кубки: \(user.wonCups)"
    }
    
    @objc func tapaddToFriendsButton() {
        
        delegate?.addToFriendsButton()
    }
    
}
