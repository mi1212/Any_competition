//
//  ProfileViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit
import SnapKit
import Lottie

protocol ProfileViewControllerDelegate: AnyObject {
    func hideCustomBarFromProfile()
    func showCustomBarFromProfile()
}

class ProfileViewController: UIViewController {
    
    var delegate : ProfileViewControllerDelegate?
    
    let userDefaults = UserDefaults.standard
    
    var isCustomBarHiden = false
    
    var hostUser: User? {
        didSet {
            addListenerToUserData()
            profileView.setupUserData(user: hostUser!)
            setupViews()
            loadingAnimationView.removeFromSuperview()
            setupNavigationBar()
        }
    }
    
    let database = Database()
    
    private let decoder = JSONDecoder()
    
    private let notificationCentre = NotificationCenter.default
    
    // MARK: - Views
    
    let profileView = ProfileView(isWithAddFriendButton: true)
    
    let loadingAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("loading")
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        self.profileView.friendsView.delegate = self
        checkUser()
        setupNavigationBar()
        requestUserData()
        addObserverToUserDatabase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isCustomBarHiden {
            delegate?.showCustomBarFromProfile()
            isCustomBarHiden.toggle()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Navigation
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .anyDarckColor
        
        let bell = UIImage(named: "bell")
        let bellWithNotification = UIImage(named: "bell+")
        let gear = UIImage(named: "settings")
        if let check = hostUser?.notificationArray.isEmpty {
            if check {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: bell,
                    style: .done,
                    target: self,
                    action: #selector(presentNotificationController)
                )
            } else {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                    image: bellWithNotification,
                    style: .done,
                    target: self,
                    action: #selector(presentNotificationController)
                )
            }
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: gear,
            style: .plain,
            target: self,
            action: #selector(presentSettingsController)
        )
    }
    
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
    private func setupLoading() {
        self.view.addSubview(loadingAnimationView)
        loadingAnimationView.layer.opacity = 1
        loadingAnimationView.play()
        NSLayoutConstraint.activate([
            loadingAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingAnimationView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func checkUser() {
        if hostUser != nil {
            setupViews()
            profileView.setupUserData(user: hostUser!)
        } else {
            setupLoading()
        }
    }
    
    @objc func presentNotificationController() {
        if !isCustomBarHiden {
            delegate?.hideCustomBarFromProfile()
            isCustomBarHiden.toggle()
            let vc = NotificationViewController(hostUser: hostUser!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func presentSettingsController() {
        if !isCustomBarHiden {
            delegate?.hideCustomBarFromProfile()
            isCustomBarHiden.toggle()
            let vc = SettingsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - dismissKeyboardTap
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return tap
    }()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - user data
    
    private func requestUserData() {
        if let uid = userDefaults.object(forKey: "uid") {
            database.getUserData(uid: uid as! String)
        }
    }
    
    private func addListenerToUserData() {
        if let docId = hostUser?.docId {
            database.addListenerToUser(docId)
        }
    }
    
    func addObserverToUserDatabase() {
        database.userDatabase.subscribe { [self] userData in
            print("--- user data was changed ")
            print(userData)
            if userData != hostUser {
                self.hostUser = userData
                print(self.hostUser?.notificationArray)
            }
        }
    }
}

extension ProfileViewController: FriendsCollectionViewDelegate {
    func tapToCell(user: User) {
        if let hostUser = hostUser {
            let vc = FriendViewController(hostUser: hostUser, choosedUser: user)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tapToCell() {

    }
    
    func tapFriendButton() {
        let vc = FriendsViewController()
        vc.hostUser = hostUser
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapAddFriendButton() {
        let vc = FindToAddUserViewController()
        vc.hostUser = hostUser
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

