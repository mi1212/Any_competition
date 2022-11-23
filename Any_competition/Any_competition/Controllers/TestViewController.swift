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
        view.backgroundColor = .anyPurpleColor
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label = AnyCompLogoUILabel()
    
    let userLabel = AnyCompUILabel(title: "добавить пользователя", fontSize: .small)
    
    let userTextField = AnyCompUITextField(placeholder: "Поиск пользователя", isSecure: false)
    
    let followersCollectionView = FriendsCollectionView()
    
    let testButton = AnyCompLoadinUIButton(title: "Test")
    
    private lazy var tableView = SearchTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.database.delegate = self
        self.database.getAllUsers()
//        setupView()
        setupObserver()
//        setupCollectionView()
    }
    
//    private func setupView() {
//        self.view.addSubview(contentView)
//        contentView.addSubview(label)
//        contentView.addSubview(userLabel)
//        contentView.addSubview(userTextField)
//
//        contentView.addSubview(testButton)
//        testButton.addTarget(self, action: #selector(tapTestButton), for: .touchUpInside)
//
//        let inset: CGFloat = 16
//
//        NSLayoutConstraint.activate([
//            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
//            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
//            contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8),
//            contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//        ])
//
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
//        ])
//
//        NSLayoutConstraint.activate([
//            userLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
//            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//        ])
//
//        NSLayoutConstraint.activate([
//            userTextField.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: inset),
//            userTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            userTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            userTextField.heightAnchor.constraint(equalToConstant: 52)
//        ])
//
//        NSLayoutConstraint.activate([
//            testButton.heightAnchor.constraint(equalToConstant: 64),
//            testButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            testButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            testButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
    
//    private func setupCollectionView() {
//        contentView.addSubview(followersCollectionView)
//
//        let inset = CGFloat(16)
//
//        NSLayoutConstraint.activate([
//            followersCollectionView.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: inset),
//            followersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
//            followersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
//            followersCollectionView.heightAnchor.constraint(equalToConstant: 150)
//        ])
//    }
    
//    private func setupSearchTableView() {
//        self.view.addSubview(tableView)
//
//        let inset = CGFloat(16)
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset),
//            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
//            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
//            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset)
//        ])
//    }
    
    private func setupObserver() {
        userTextField.rx.text
            .orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [self]query in
//                setupSearchTableView()
                TestViewController.foundUsers = TestViewController.users.filter { $0.nick.hasPrefix(query) ||  $0.firstName.hasPrefix(query) ||  $0.lastName.hasPrefix(query)}
                tableView.tableView.reloadData()
                print("\(query)")
                print("\(TestViewController.foundUsers)")
            }).disposed(by: disposeBag)
    }
    
    @objc func tapTestButton() {
        testButton.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [self] in
                testButton.isLoading = false
            }
    }
}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TestViewController.users.count
//        TestViewController.foundUsers.count
//        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifire, for: indexPath)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height))
        label.text = TestViewController.foundUsers[indexPath.row].nick + " " + TestViewController.foundUsers[indexPath.row].firstName + " " + TestViewController.foundUsers[indexPath.row].lastName
        cell.backgroundColor = .white
        cell.contentView.addSubview(label)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? UITableViewCell
        print(cell)
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
//        tableView.reloadData()
    }
    
    
}
