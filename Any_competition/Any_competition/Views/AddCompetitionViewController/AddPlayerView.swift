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
    
    func tapCancelButtonAddPlayerView()
}

class AddPlayerView: UIView {
    
    var delegate: AddPlayerViewDelegate?
    
    var users = [User]()
    
    var foundUsers = [User]()
    
    let disposeBag = DisposeBag()
    
    // MARK: UIViews
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .anyGreenColor
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label = AnyCompLogoUILabel()
    
    let userLabel = AnyCompUILabel(title: "добавить пользователя", fontSize: .small)
    
    let userTextField = AnyCompUITextField(placeholder: "Поиск пользователя", isSecure: false)
    
    let searchTable = SearchTableView()
    
    let cancelButton = AnyCompUIButton(title: "Выйти")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        searchTable.isExclusiveTouch = true
        setupSearchTableView()
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
        contentView.addSubview(searchTable)
        contentView.addSubview(cancelButton)

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
        ])
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: inset),
            userTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            userTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            userTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            cancelButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2),
            cancelButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.15),
        ])
    }
    
    private func setupSearchTableView() {
        contentView.addSubview(searchTable)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            searchTable.leadingAnchor.constraint(equalTo: userTextField.leadingAnchor),
            searchTable.trailingAnchor.constraint(equalTo: userTextField.trailingAnchor),
            searchTable.topAnchor.constraint(equalTo: userTextField.bottomAnchor),
            searchTable.bottomAnchor.constraint(equalTo: cancelButton.topAnchor),
        ])
    }
    
    @objc func tapCancelButton() {
        animationTapButton(cancelButton)
        delegate?.tapCancelButtonAddPlayerView()
    }
    
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
                } else {
                    foundUsers = [User]()
                }
                searchTable.foundUsers = foundUsers
//                searchTable.tableView.reloadData()
            }).disposed(by: disposeBag)

    }
 
}


