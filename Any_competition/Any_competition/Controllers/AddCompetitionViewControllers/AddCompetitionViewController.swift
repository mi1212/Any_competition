//
//  AddCompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import RxCocoa
import RxSwift

class AddCompetitionViewController: UIViewController {

    let database = Database()
    
    var playersArray: [User] = []
    
    var accessUserArray: [User] = []
    
    let competitionTitleTextField = AnyCompUITextField(placeholder: "Название", isSecure: false)
    // массивы для поиска
    var users = [User]() {
        didSet{
//            addPlayerView.users = self.users
        }
    }
    
    // тумблер показать/скрыть addPlayerView
//    var isSetupAddPlayerView = false {
//        didSet{
//            switch self.isSetupAddPlayerView {
//            case true:
//                setupAddPlayerView()
//            case false:
//                closeAddPlayerView()
//            }
//        }
//    }
    // массив пользователей найденных в поиске
    var foundUsers = [User]() {
        didSet{
//            SearchTableView.users = self.users
        }
    }
    
    var searchText: String? = nil
    
    let disposeBag = DisposeBag()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isExclusiveTouch = true
        scroll.isUserInteractionEnabled = true
        scroll.canCancelContentTouches = true
        scroll.delaysContentTouches = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    let playersTable = PlayersTableCollectionView()
    
    let playersTableLabel = AnyCompUILabel(title: "Игроки", fontSize: .small)

    //    let addPlayerButton = AnyCompUIButton(title: "Добавить игроков")
    
    let addCompetitionButton = AnyCompUIButton(title: "Готово")
    
//    let addPlayerView = AddPlayerView()
    
    let userTextField = AnyCompUITextField(placeholder: "Поиск пользователя", isSecure: false)
    
    let searchTable = SearchTableView()
    
    var cons: NSLayoutConstraint?
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "ошибка", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupController()
        addCompetitionButton.addTarget(self, action: #selector(tapAddCompetitionButton), for: .touchUpInside)
//        self.view.addGestureRecognizer(tap) // при добавлении жеста перестает работать didSelectRow в таблице addPlayer
        self.database.getAllUsers()
        addObserverToUser()
//        choosedUser()
        addOwnUserToPlayersArray()
        setupObserver()
    }
    
    private func setupController() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(competitionTitleTextField)
        contentView.addSubview(playersTableLabel)
        contentView.addSubview(userTextField)
        
        contentView.addSubview(playersTable)
//        contentView.addSubview(addPlayerButton)
        contentView.addSubview(addCompetitionButton)
                
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            competitionTitleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            competitionTitleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            competitionTitleTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset*3),
            competitionTitleTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        
        
        NSLayoutConstraint.activate([
            playersTableLabel.topAnchor.constraint(equalTo: competitionTitleTextField.bottomAnchor, constant: inset),
            playersTableLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            playersTableLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: playersTableLabel.bottomAnchor, constant: inset),
            userTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            userTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            userTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            playersTable.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: inset),
            playersTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            playersTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
        ])
        
        
        
//        NSLayoutConstraint.activate([
//            addPlayerButton.topAnchor.constraint(equalTo: playersTable.bottomAnchor, constant: inset*2),
//            addPlayerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            addPlayerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            addPlayerButton.heightAnchor.constraint(equalToConstant: 64)
//        ])
        
        NSLayoutConstraint.activate([
//            addCompetitionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            addCompetitionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            addCompetitionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            addCompetitionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addCompetitionButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            addCompetitionButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        contentView.addSubview(searchTable)
        
        NSLayoutConstraint.activate([
            searchTable.leadingAnchor.constraint(equalTo: userTextField.leadingAnchor),
            searchTable.trailingAnchor.constraint(equalTo: userTextField.trailingAnchor),
            searchTable.topAnchor.constraint(equalTo: userTextField.bottomAnchor),
            searchTable.bottomAnchor.constraint(equalTo: addCompetitionButton.topAnchor),
        ])
    }
    // установить вью добавления игрока
//    private func setupAddPlayerView() {
//        self.view.addSubview(addPlayerView)
//        addPlayerView.delegate = self
//        addPlayerView.searchTable.foundUsers = foundUsers
//
//        let inset: CGFloat = 16
//
//        NSLayoutConstraint.activate([
//            addPlayerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            addPlayerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            addPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
//            addPlayerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
//        ])
//
//        addPlayerView.layer.opacity = 0.2
//        addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
//        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
//            addPlayerView.layer.opacity = 1
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
//        } completion: { [self] _ in
//            addPlayerView.layer.opacity = 1
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1, y: 1)
//        }
//    }
    // убрать вью добавления игрока
//    private func closeAddPlayerView() {
//        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
//            addPlayerView.layer.opacity = 0.2
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
//        } completion: { [self] _ in
//            addPlayerView.removeFromSuperview()
//            addPlayerView.layer.opacity = 1
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
//            addPlayerView.userTextField.text = ""
//        }
//    }
    // презентовать вью добавления игроков в соревнование
//    @objc func tapAddPlayerButton() {
//        animationTapButton(addPlayerButton)
//        self.isSetupAddPlayerView.toggle()
//    }
    // добавление соревнования в базу данных
    @objc func tapAddCompetitionButton() {
        
        animationTapButton(addCompetitionButton)
        
        if TabBarController.user != nil {

            let playerQty = playersArray.count
            
            let title = competitionTitleTextField.text
            
            if title == "" {
                
                shakeTextFieldifEmpty(competitionTitleTextField)
                
            } else if playerQty < 2 {
                shakeTextFieldifEmpty(competitionTitleTextField)
                alert.message = "добавьте минимум 2 игрока"
                self.present(alert, animated: true)
            } else {
                shakeTextFieldifEmpty(competitionTitleTextField)
                let competition = Competition(
                    title: title!,
                    qtyPlayers: playerQty,
                    date: Date.now.description,
                    players: playersArray,
                    accessUserIdArray: playersArray.map {$0.id!}
                )
                
                database.sendCompetitionToDatabase(competition: competition)
                
                dismiss(animated: true, completion: nil)
            }
            
        } else {
            alert.message = "необходимо авторизоваться"
            self.present(alert, animated: true)
        }
        
    }
    
    private func alertMessage(message: String){
        let alert = UIAlertController(title: "\(message)", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return tap
    }()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addObserverToUser() {
        database.usersDatabase.subscribe(onNext: { [self] value in
            users = value
        })
    }
    
//    private func choosedUser() {
//        addPlayerView.searchTable.choosedUser.subscribe { [self] user in
//
//            if playersArray.contains(user) {
//                print("--- user has already added")
//            } else {
//                self.playersArray.append(user)
//
//                playersTable.playersArray = self.playersArray
//                playersTable.collectionView.reloadData()
//                cons?.isActive = false
//
//                cons = playersTable.heightAnchor.constraint(equalToConstant: CGFloat(52*playersArray.count))
//
//                cons?.isActive = true
//
//                self.view.reloadInputViews()
//            }
//        }
//    }
    
    private func setupObserver() {
        userTextField.rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
//            .filter({ string in
//                string != ""
//            })
            .subscribe(onNext: { [self] query in
                if query != "" {
                    foundUsers = users.filter { $0.nick.hasPrefix(query) ||  $0.firstName.hasPrefix(query) ||  $0.lastName.hasPrefix(query)}
                    print(query)
                    print(foundUsers)
                    
                } else {
                    foundUsers = [User]()
                }
                searchTable.foundUsers = foundUsers
//                searchTable.tableView.reloadData()
            }).disposed(by: disposeBag)

    }
    
    private func addOwnUserToPlayersArray() {
        if let user = TabBarController.user {
            self.playersArray.append(user)
            playersTable.playersArray = self.playersArray
            playersTable.collectionView.reloadData()
            cons?.isActive = false

            cons = playersTable.heightAnchor.constraint(equalToConstant: CGFloat(52*playersArray.count))

            cons?.isActive = true
        } else {
            print("--- user did not find")
        }
        
    }
    
}

//extension AddCompetitionViewController: AddPlayerViewDelegate {
//    func tapAddButton(player: User) {
//
//        self.playersArray.append(player)
//
//        playersTable.playersArray = self.playersArray
//        playersTable.collectionView.reloadData()
//        cons?.isActive = false
//
//        cons = playersTable.heightAnchor.constraint(equalToConstant: CGFloat(52*playersArray.count))
//
//        cons?.isActive = true
//
//        self.view.reloadInputViews()
//        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
//            addPlayerView.layer.opacity = 0.2
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
//        } completion: { [self] _ in
//            addPlayerView.removeFromSuperview()
//            addPlayerView.layer.opacity = 1
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
//        }
//    }
//
//    func tapCancelButtonAddPlayerView() {
//        self.isSetupAddPlayerView.toggle()
//    }
//
//
//}
