//
//  ProfileViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit
import SnapKit
//import Lottie
//import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    static var user: User?
    
    let database = Database()
    
    private let decoder = JSONDecoder()
    
    private let notificationCentre = NotificationCenter.default
    
    // MARK: - Views
    
    let profileView = ProfileView()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        view.backgroundColor = .anyPurpleColor
        setupNavigationBar()
//        setupViews()
//        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Navigation
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .anyDarckColor
        
        let plus = UIImage(systemName: "bell")
        let gear = UIImage(systemName: "gear")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: plus,
            style: .done,
            target: self,
            action: #selector(presentNotificationController)
        )
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
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
            make.edges.equalToSuperview()
        }
        
    }
    
//    private func setupAddPlayerView() {
//        self.view.addSubview(addPlayerView)
////        addPlayerView.delegate = self
//
//        let inset: CGFloat = 16
//
//        NSLayoutConstraint.activate([
//            addPlayerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            addPlayerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            addPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
//            addPlayerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
//        ])
//
//        addPlayerView.layer.opacity = 0.2
//        addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
//        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
//            addPlayerView.layer.opacity = 1
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
//        } completion: { [self] _ in
//            addPlayerView.layer.opacity = 1
//            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1, y: 1)
//        }
//    }
    
    @objc func presentNotificationController() {
            let vc = NotificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func presentSettingsController() {
            let vc = SettingsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
    }
        
    //MARK: - dismissKeyboardTap
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return tap
    }()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//extension ProfileViewController: ProfileViewDelegate {
//
//    func exitFromProfileView() {
//
//        ProfileViewController.user = nil
//        database.removeListenerToCompetitionCollection()
//        userDefaults.set(nil, forKey: "uid")
//        CompetitionsViewController.isAddedListener = false
//        UIView.animate(withDuration: 1, delay: 0) { [self] in
//            loginView.transform = loginView.transform.translatedBy(x: -self.view.layer.bounds.width, y: 0)
//            profileView.transform = profileView.transform.translatedBy(x: -self.view.layer.bounds.width, y: 0)
//        } completion: { _ in
//
//        }
//    }
//
//}
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

//extension ProfileViewController: FriendsCollectionViewDelegate {
//    func tapAddFriendButton() {
//        let vc = FindToAddUserViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}

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
