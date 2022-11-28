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
//        self.backgroundColor = .systemPink
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
//            make.height.width.equalTo(self.snp.height).multipliedBy(0.20)
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
            make.height.equalTo(self.snp.height).multipliedBy(0.13)
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
//        friendsView.backgroundColor = .tintColor
    }
    
    private func setupProperts() {
        print(self.layer.bounds)
        print(self.layer)
        print(self.bounds)
//        photoView.layer.cornerRadius = self.layer.bounds.height/20
        photoView.layer.cornerRadius = 40
        statisticStack.layer.cornerRadius = 16
        
        
    }
    
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
