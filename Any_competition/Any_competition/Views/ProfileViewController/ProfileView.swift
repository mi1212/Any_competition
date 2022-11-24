//
//  ProfileView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 18.10.2022.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
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
    
    private lazy var photoView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .anyGreenColor
        image.image = UIImage(named: "userPhoto")
        image.contentMode = .scaleAspectFill
        image.tintColor = .anyDarckColor
        image.clipsToBounds = true
        return image
    }()

    let nameLabel = AnyCompUILabel(title: "", fontSize: .medium)

    let statisticStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        stack.backgroundColor = .anyPurpleColor
        stack.alignment = .fill
        stack.distribution = .equalCentering
        return stack
    }()
    
    let wonGamesView = StatisticView(imageViewName: "wonGames", name: "Побед", qty: "8")
    
    let lostGamesView = StatisticView(imageViewName: "lostGames", name: "Поражений", qty: "3")
    
    let wonCupsView = StatisticView(imageViewName: "wonCups", name: "Кубков", qty: "2")

    let friendsView = FriendsCollectionView()
    
//    let exitButton = AnyCompClearUIButton(title: "Выйти из профиля")
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupProperts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        self.addSubview(photoView)
        self.addSubview(nameLabel)
        self.addSubview(statisticStack)
        statisticStack.addArrangedSubviews([wonGamesView, lostGamesView, wonCupsView])
        self.addSubview(friendsView)
        
        photoView.snp.makeConstraints { make in
            make.height.width.equalTo(80)
            make.top.equalTo(self)
            make.centerX.equalTo(self)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(photoView.snp.bottom).offset(21)
        }
        
        statisticStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(nameLabel.snp.bottom).offset(24)
            make.height.equalTo(100)
        }
        
        let statisticViewsArray = [wonGamesView, lostGamesView, wonCupsView]
        statisticViewsArray.map {
            $0.snp.makeConstraints { make in
                make.top.bottom.equalTo(statisticStack)
                make.width.equalToSuperview().multipliedBy(0.3)
            }
        }
        
        friendsView.snp.makeConstraints { make in
            make.top.equalTo(statisticStack.snp.bottom).inset(-16)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setupProperts() {
        photoView.layer.cornerRadius = 40
        statisticStack.layer.cornerRadius = 16
        
        
    }
//    private func setupViews() {
//        self.addSubview(nickLabel)
//
//        self.addSubview(photoView)
//        self.addSubview(nameStackView)
//        nameStackView.addArrangedSubview(firstNameLabel)
//        nameStackView.addArrangedSubview(lastNameLabel)
//
//        self.addSubview(stackView)
//        stackView.addArrangedSubview(playedGamesLabel)
//        stackView.addArrangedSubview(wonGamesLabel)
//        stackView.addArrangedSubview(lostGamesLabel)
//        stackView.addArrangedSubview(wonCupsLabel)
//
//        self.addSubview(friendsView)
//
//        self.addSubview(exitButton)
//
//        exitButton.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
//
//        firstNameLabel.textAlignment = .left
//        lastNameLabel.textAlignment = .left
//        nickLabel.textAlignment = .center
//
//
//        let inset: CGFloat = 16
//
//        NSLayoutConstraint.activate([
//            nickLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset*2),
//            nickLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            nickLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset*2),
//        ])
//
//        NSLayoutConstraint.activate([
//            photoView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset),
//            photoView.bottomAnchor.constraint(equalTo: nameStackView.bottomAnchor),
//            photoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
//            photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            nameStackView.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: inset),
//            nameStackView.leadingAnchor.constraint(equalTo: photoView.trailingAnchor, constant: inset),
//            nameStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            nameStackView.heightAnchor.constraint(equalToConstant: inset*5)
//        ])
//
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: inset),
//            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
//            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            stackView.heightAnchor.constraint(equalToConstant: inset*6)
//        ])
//
//        NSLayoutConstraint.activate([
//            friendsView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: inset),
//            friendsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
//            friendsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            friendsView.heightAnchor.constraint(equalToConstant: inset*10)
//        ])
//
//        NSLayoutConstraint.activate([
//            exitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
//            exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
//            exitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset*2),
//        ])
//    }
    
    func setupUserData(user: User) {
//        nickLabel.text = user.nick
        nameLabel.text! = user.firstName + " " + user.lastName
//        lastNameLabel.text! = user.lastName
//        playedGamesLabel.text! = "Игры: \(user.playedGames)"
//        wonGamesLabel.text! = "Победы: \(user.wonGames)"
//        lostGamesLabel.text! = "Поражения: \(user.lostGames)"
//        wonCupsLabel.text! = "Кубки: \(user.wonCups)"
    }
    
}
