//
//  AddPlayerView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 01.11.2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol AddPlayerViewDelegate: AnyObject {
    func tapAddButton(player: User)
    
    func tapCancelButton()
}

class AddPlayerView: UIView {
    
    var delegate: AddPlayerViewDelegate?
    
    let disposeBag = DisposeBag()
    
    // MARK: UIViews
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .anyColor1
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label = AnyCompLogoUILabel()
    
    let userLabel = AnyCompUILabel(title: "добавить пользователя", fontSize: .small)
    
    let userTextField = AnyCompUITextField(placeholder: "Поиск пользователя", isSecure: false)
    
    let playerLabel = AnyCompUILabel(title: "ввести данные игрока", fontSize: .small)
    
    let firstNameTextField = AnyCompUITextField(placeholder: "Имя", isSecure: false)
    
    let lastNameTextField = AnyCompUITextField(placeholder: "Фамилия", isSecure: false)
    
    let nickNameTextField = AnyCompUITextField(placeholder: "Ник в игре", isSecure: false)
    
    let searchTable = SearchTableView()
       
    let addButton = AnyCompUIButton(title: "Добавить")
    
    let cancelButton = AnyCompUIButton(title: "Выйти")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        setupObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(contentView)
        contentView.addSubview(label)
        label.text = "Игрок"
        contentView.addSubview(userLabel)
        contentView.addSubview(userTextField)
//        contentView.addSubview(playerLabel)
//        contentView.addSubview(firstNameTextField)
//        contentView.addSubview(lastNameTextField)
//        contentView.addSubview(nickNameTextField)
        contentView.addSubview(searchTable)
//        contentView.addSubview(addButton)
        contentView.addSubview(cancelButton)

        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            contentView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
        ])
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            userLabel.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: inset),
            userTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            userTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            userTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
//        NSLayoutConstraint.activate([
//            playerLabel.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 2*inset),
//            playerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            playerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
////            userLabel.heightAnchor.constraint(equalToConstant: 52)
//        ])
        
//        NSLayoutConstraint.activate([
//            firstNameTextField.topAnchor.constraint(equalTo: playerLabel.bottomAnchor, constant: inset),
//            firstNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            firstNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            firstNameTextField.heightAnchor.constraint(equalToConstant: 52)
//        ])
//
//        NSLayoutConstraint.activate([
//            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: inset),
//            lastNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            lastNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            lastNameTextField.heightAnchor.constraint(equalToConstant: 52)
//        ])
//
//        NSLayoutConstraint.activate([
//            nickNameTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: inset),
//            nickNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            nickNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            nickNameTextField.heightAnchor.constraint(equalToConstant: 52)
//        ])
        
//        NSLayoutConstraint.activate([
//            searchTable.topAnchor.constraint(equalTo: userTextField.bottomAnchor),
//            searchTable.leadingAnchor.constraint(equalTo: userTextField.leadingAnchor),
//            searchTable.trailingAnchor.constraint(equalTo: userTextField.trailingAnchor),
//            searchTable.bottomAnchor.constraint(equalTo: cancelButton.topAnchor)
//        ])
        
//        NSLayoutConstraint.activate([
//            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: inset),
//            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            addButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2),
//            addButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
//        ])
        
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
//            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            cancelButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor),
            cancelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2),
            cancelButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15),
        ])
    }
    
    func clearTextFields() {
        let textFieldArray = [firstNameTextField, lastNameTextField, nickNameTextField]
        
        textFieldArray.map {
            $0.text = ""
            $0.backgroundColor = .white
            
        }
    }
    
    @objc func tapAddButton() {
        animationTapButton(addButton)
        
        guard let firstName = firstNameTextField.text else {return}
        
        guard let lastName = lastNameTextField.text else {return}
        
        guard let nick = nickNameTextField.text else {return}
        
        let textFieldArray = [firstNameTextField, lastNameTextField, nickNameTextField]
        
        if firstName != "" && lastName != "" && nick != "" {
            let player = User(firstName: firstName, lastName: lastName, nick: nick)
            
            delegate?.tapAddButton(player: player)
        } else {
            textFieldArray.map {
                shakeTextFieldifEmpty($0)
            }
            
        }
        
    }
    
    @objc func tapCancelButton() {
        animationTapButton(cancelButton)
        delegate?.tapCancelButton()
    }
    
    private func setupObserver() {
        userTextField.rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ string in
                string != ""
            })
            .subscribe(onNext: { [self] query in
//                TestViewController.foundUsers = TestViewController.users.filter { $0.nick.hasPrefix(query) ||  $0.firstName.hasPrefix(query) ||  $0.lastName.hasPrefix(query)}
                print(query)
                searchTable.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
 
}


