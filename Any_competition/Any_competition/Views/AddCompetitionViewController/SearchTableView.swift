//
//  SearchTableView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 09.11.2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchTableView: UIView {
    
    let dataBase = Database()
    
    var foundUsers = [User]() {
        didSet{
            numberOfItems = self.foundUsers.count
        }
    }
    
    var numberOfItems = 0 {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    var choosedUser = PublishRelay<User>()
    
    let tableView: UITableView = {
        let table = UITableView()
//        table.backgroundColor = .white
        table.backgroundColor = .clear
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifire)
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifire)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .white
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        setupView()
        dataBase.getAllUsers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(tableView)
        
        let inset = CGFloat(16)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

extension SearchTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifire, for: indexPath) as! SearchTableViewCell
        let user = foundUsers[indexPath.row]
        cell.setupCell(firstName: user.firstName, lastName: user.lastName, nickName: user.nick)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        choosedUser.accept(foundUsers[indexPath.row])
    }
}
