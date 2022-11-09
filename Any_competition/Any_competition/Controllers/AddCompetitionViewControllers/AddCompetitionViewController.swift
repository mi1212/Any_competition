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
    
    var playersArray: [Player] = []
    
    let competitionTitleTextField = AnyCompUITextField(placeholder: "Название", isSecure: false)
    
    static var users = [User]()
    
    static var foundUsers = [User]()
    
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
    
    let playersTable = playersTableCollectionView()
    
    let addPlayerButton = AnyCompUIButton(title: "Добавить игроков")
    
    let addCompetitionButton = AnyCompUIButton(title: "Готово")
    
    let addPlayerView = AddPlayerView()
    
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
        self.view.addGestureRecognizer(tap)
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
    
    private func setupAddPlayerView() {
        self.view.addSubview(addPlayerView)
        addPlayerView.delegate = self
        
        
        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            addPlayerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            addPlayerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            addPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            addPlayerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
        ])
        
        addPlayerView.layer.opacity = 0.2
        addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
            addPlayerView.layer.opacity = 1
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
        } completion: { [self] _ in
            addPlayerView.layer.opacity = 1
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1, y: 1)
        }

    }
    
    @objc func tapAddPlayerButton() {

        animationTapButton(addPlayerButton)
        
        setupAddPlayerView()
        
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
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return tap
    }()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension AddCompetitionViewController: AddPlayerViewDelegate {
    func tapAddButton(player: Player) {
        
        self.playersArray.append(player)

        playersTable.playersArray = self.playersArray
        playersTable.collectionView.reloadData()
        cons?.isActive = false

        cons = playersTable.heightAnchor.constraint(equalToConstant: CGFloat(52*playersArray.count))

        cons?.isActive = true

        self.view.reloadInputViews()
        addPlayerView.clearTextFields()
        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
            addPlayerView.layer.opacity = 0.2
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
        } completion: { [self] _ in
            addPlayerView.removeFromSuperview()
            addPlayerView.layer.opacity = 1
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
        }
    }
    
    func tapCancelButton() {
        addPlayerView.clearTextFields()
        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
            addPlayerView.layer.opacity = 0.2
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
        } completion: { [self] _ in
            addPlayerView.removeFromSuperview()
            addPlayerView.layer.opacity = 1
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
        }
        
    }
    
    
}
