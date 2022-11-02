//
//  TestViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 04.10.2022.
//

import UIKit
import RxCocoa
import RxSwift

class TestViewController: UIViewController {
    
    let database = Database()
    
    static var users = [User]()
    
    static var foundUsers = [User]()
    
    var searchText: String? = nil
    
    let disposeBag = DisposeBag()
    
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
    
    
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.database.delegate = self
        self.database.getAllUsers()
        setupView()
        setupObserver()
    }
    
    private func setupView() {
        self.view.addSubview(contentView)
        contentView.addSubview(label)
        contentView.addSubview(userLabel)
        contentView.addSubview(userTextField)
        contentView.addSubview(tableView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8),
            contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
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
        ])
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: inset),
            userTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            userTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            userTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userTextField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            tableView.heightAnchor.constraint(equalToConstant: CGFloat(52*TestViewController.users.count))
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            tableView.heightAnchor.constraint(equalToConstant: CGFloat(600))
        ])
    }
    
    private func setupObserver() {
        userTextField.rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [self]query in
                TestViewController.foundUsers = TestViewController.users.filter { $0.nick.hasPrefix(query) }
                print(TestViewController.foundUsers)
                tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}
extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        TestViewController.users.count
        TestViewController.foundUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height))
        label.text = TestViewController.foundUsers[indexPath.row].nick + " " + TestViewController.foundUsers[indexPath.row].firstName + " " + TestViewController.foundUsers[indexPath.row].lastName
        cell.backgroundColor = .white
//        label.text = TestViewController.users[indexPath.row].nick + " " + TestViewController.users[indexPath.row].firstName + " " + TestViewController.users[indexPath.row].lastName
        cell.contentView.addSubview(label)
        return cell
    }
    
    
}

extension TestViewController: DatabaseDelegate {
    func reloadView(competitions: [Competition]) {
        
    }
    
    func reloadViewWithoutAnimate(user: User) {
        
    }
    
    func animateAndReloadView(user: User) {
        
    }
    
    func reloadTableCollectionView() {
        
    }
    
    func alertMessage(alertMessage: String) {
        
    }
    
    func receivedAllUsers(users: [User]) {
        print(users.map {$0.nick})
        
        TestViewController.users = users
        tableView.reloadData()
    }
    
    
}
