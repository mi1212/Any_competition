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
    
    var user: User? {
        didSet {
            profileView.setupUserData(user: user!)
            setupViews()
            
            loadingAnimationView.removeFromSuperview()
        }
    }
    
    let database = Database()
    
    private let decoder = JSONDecoder()
    
    private let notificationCentre = NotificationCenter.default
    
    // MARK: - Views
    
    let profileView = ProfileView()
    
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
        //        self.view.addGestureRecognizer(tap)
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
        
        let plus = UIImage(named: "bell")
        let gear = UIImage(named: "settings")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: plus,
            style: .done,
            target: self,
            action: #selector(presentNotificationController)
        )
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
        if user != nil {
            setupViews()
            profileView.setupUserData(user: user!)
        } else {
            setupLoading()
        }
    }
    
    @objc func presentNotificationController() {
        if !isCustomBarHiden {
            delegate?.hideCustomBarFromProfile()
            isCustomBarHiden.toggle()
            let vc = NotificationViewController()
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
    
    func addObserverToUserDatabase() {
        database.userDatabase.subscribe { [self] userData in
            self.user = userData
        }
    }
}
//
//extension ProfileViewController: DatabaseDelegate {
//    func receivedAllUsers(users: [User]) {
//
//    }
//
//
//    func reloadViewWithoutAnimate(user: User) {
//        ProfileViewController.user = user
//        loadingAnimationView.stop()
//        loadingAnimationView.layer.opacity = 0
//        setupViewsWithoutLogin()
//        profileView.user = user
////        profileView.setupData(user: ProfileViewController.user!)
//    }
//
//    func animateAndReloadView(user: User) {
//        ProfileViewController.user = user
//
//        profileView.setupData(user: user)
//
//        loadingAnimationView.removeFromSuperview()
//
//        UIView.animate(withDuration: 1, delay: 0) { [self] in
//            profileView.transform = profileView.transform.translatedBy(x: self.view.layer.bounds.width, y: 0)
//        }
//    }
//
//    func alertMessage(alertMessage: String) {
//        loadingAnimationView.removeFromSuperview()
//        alert.message = alertMessage
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func reloadView(competitions: [Competition]) {}
//
//    func reloadTableCollectionView() {}
//
//}

extension ProfileViewController: FriendsCollectionViewDelegate {
    func tapToCell() {
        let vc = FriendViewController()
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapFriendButton() {
        let vc = FriendsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tapAddFriendButton() {
        let vc = FindToAddUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//extension ProfileViewController: AddPlayerViewDelegate {
//    func tapAddButton(player: User) {}
//
//    func tapCancelButtonAddPlayerView() {
//        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
//            addPlayerView.layer.opacity = 0.2
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
//        } completion: { [self] _ in
//            addPlayerView.removeFromSuperview()
//            addPlayerView.layer.opacity = 1
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
//        }
//    }
//}
