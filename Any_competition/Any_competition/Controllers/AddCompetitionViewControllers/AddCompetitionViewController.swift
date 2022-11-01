//
//  AddCompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit

class AddCompetitionViewController: UIViewController {

    let database = Database()
    
    var playersArray: [Player] = []
    
    let competitionTitleTextField = AnyCompUITextField(placeholder: "Название", isSecure: false)
    
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
    
    let playersTable = playersTableCollectionView()
    
    let addPlayerButton = AnyCompUIButton(title: "Добавить игроков")
    
    let addCompetitionButton = AnyCompUIButton(title: "Готово")
    
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
        addPlayerButton.addTarget(self, action: #selector(tapAddPlayerButton), for: .touchUpInside)
        addCompetitionButton.addTarget(self, action: #selector(tapAddCompetitionButton), for: .touchUpInside)
    }
    
    private func setupController() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(competitionTitleTextField)
        contentView.addSubview(playersTable)
        contentView.addSubview(addPlayerButton)
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
            playersTable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            playersTable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            playersTable.topAnchor.constraint(equalTo: competitionTitleTextField.bottomAnchor, constant: inset),
        ])
        
        NSLayoutConstraint.activate([
            addPlayerButton.topAnchor.constraint(equalTo: playersTable.bottomAnchor, constant: inset*2),
            addPlayerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            addPlayerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            addPlayerButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            addCompetitionButton.topAnchor.constraint(equalTo: addPlayerButton.bottomAnchor, constant: inset*2),
            addCompetitionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            addCompetitionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            addCompetitionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            addCompetitionButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    @objc func tapAddPlayerButton() {

        animationTapButton(addPlayerButton)
        
        let alert = UIAlertController(title: "Введите данные игрока", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Имя"
        }
        
        alert.addTextField { (secondNameTextField) in
            secondNameTextField.placeholder = "Фамилия"
        }
        
        alert.addTextField { (nickTextField) in
            nickTextField.placeholder = "Ник"
        }
        
        alert.addAction(UIAlertAction(title: "отмена", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "добавить", style: .default, handler: { [self] _ in
            guard let firstname = alert.textFields![0].text else {return}
            guard let lastName = alert.textFields![1].text  else {return}
            guard let nick = alert.textFields![2].text  else {return}

            let player = Player(firstName: firstname, lastName: lastName, nick: nick)

            playersArray.append(player)
            
            playersTable.playersArray = playersArray
            playersTable.collectionView.reloadData()
            
            cons?.isActive = false

            cons = playersTable.heightAnchor.constraint(equalToConstant: CGFloat(52*playersArray.count))
            
            cons?.isActive = true
            
            self.view.reloadInputViews()
            
        }))
        
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func tapAddCompetitionButton() {
        
        animationTapButton(addCompetitionButton)
        
        if let user = TabBarController.user {
            
            let accessUserArray = [user]
            
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
                    accessUserArray: accessUserArray
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
    
}
