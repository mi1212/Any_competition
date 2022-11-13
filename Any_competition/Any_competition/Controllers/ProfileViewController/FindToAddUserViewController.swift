//
//  FindToAddUserViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 13.11.2022.
//

import UIKit
import RxCocoa
import RxSwift

class FindToAddUserViewController: UIViewController {

    let database = Database()
    
    var users = [User]()
    
    var foundUsers = [User]()
    
    var searchText: String? = nil
    
    let disposeBag = DisposeBag()

    let label = AnyCompLogoUILabel()
    
    let userLabel = AnyCompUILabel(title: "добавить пользователя", fontSize: .small)
    
    let userTextField = AnyCompUITextField(placeholder: "Поиск пользователя", isSecure: false)
    
    let searchTable = SearchTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        database.getAllUsers()
        addObserverToUser()
        setupObserverToTextField()
        setupViews()
        setupSearchTableView()
    }
    
    private func setupViews() {
        self.view.addSubview(label)
        self.view.addSubview(userLabel)
        self.view.addSubview(userTextField)

        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: inset),
        ])

        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            userLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            userLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
        ])

        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: inset),
            userTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            userTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            userTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    private func setupSearchTableView() {
        self.view.addSubview(searchTable)
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            searchTable.leadingAnchor.constraint(equalTo: userTextField.leadingAnchor),
            searchTable.trailingAnchor.constraint(equalTo: userTextField.trailingAnchor),
            searchTable.topAnchor.constraint(equalTo: userTextField.bottomAnchor),
            searchTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
        ])
    }
    
    private func addObserverToUser() {
        database.usersDatabase.subscribe(onNext: { [self] value in
            users = value
    })
    }
    
    private func setupObserverToTextField() {
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
                } else {
                    foundUsers = [User]()
                }
//                searchTable.numberOfItems = foundUsers.count
                searchTable.foundUsers = foundUsers
//                searchTable.tableView.reloadData()
            }).disposed(by: disposeBag)

    }

}
