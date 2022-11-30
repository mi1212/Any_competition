//
//  FriendViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 29.11.2022.
//

import UIKit
import SnapKit

class FriendViewController: UIViewController {
    
    var user: User? {
        didSet {
            profileView.setupUserData(user: user!)
            setupViews()
        }
    }
    
    let database = Database()
    
    private let decoder = JSONDecoder()
    
    private let notificationCentre = NotificationCenter.default
    
    // MARK: - Views
    
    let profileView = ProfileView(isWithAddFriendButton: false)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
//        checkUser()
//        setupNavigationBar()
//        requestUserData()
//        addObserverToUserDatabase()
        //        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if isCustomBarHiden {
//            delegate?.showCustomBarFromProfile()
//            isCustomBarHiden.toggle()
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Navigation
    
//    private func setupNavigationBar() {
//        self.navigationController?.navigationBar.tintColor = .anyDarckColor
//        
//        let plus = UIImage(named: "bell")
//        let gear = UIImage(named: "settings")
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: plus,
//            style: .done,
//            target: self,
//            action: #selector(presentNotificationController)
//        )
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: gear,
//            style: .plain,
//            target: self,
//            action: #selector(presentSettingsController)
//        )
//    }
    
    // установка вьюх если не нужно залогиниться
    private func setupViews() {
        view.addSubview(profileView)
        
        profileView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom).inset(80)
        }
        
    }
    
    // установка анимации загрузки
//    private func setupLoading() {
//        self.view.addSubview(loadingAnimationView)
//        loadingAnimationView.layer.opacity = 1
//        loadingAnimationView.play()
//        NSLayoutConstraint.activate([
//            loadingAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            loadingAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            loadingAnimationView.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
    
//    private func checkUser() {
//        if user != nil {
//            setupViews()
//            profileView.setupUserData(user: user!)
//        } else {
//            setupLoading()
//        }
//    }
    
//    @objc func presentNotificationController() {
//        if !isCustomBarHiden {
//            delegate?.hideCustomBarFromProfile()
//            isCustomBarHiden.toggle()
//            let vc = NotificationViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//
//    @objc func presentSettingsController() {
//        if !isCustomBarHiden {
//            delegate?.hideCustomBarFromProfile()
//            isCustomBarHiden.toggle()
//            let vc = SettingsViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    //MARK: - dismissKeyboardTap
    
//    private lazy var tap: UITapGestureRecognizer = {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        return tap
//    }()
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
    // MARK: - user data
    
//    private func requestUserData() {
//        if let uid = userDefaults.object(forKey: "uid") {
//            database.getUserData(uid: uid as! String)
//        }
//    }
//
//    func addObserverToUserDatabase() {
//        database.userDatabase.subscribe { [self] userData in
//            self.user = userData
//        }
//    }
//}

}
