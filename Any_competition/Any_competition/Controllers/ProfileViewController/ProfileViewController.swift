//
//  ProfileViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    var user: User?
    
    let database = Database()
    
    private let decoder = JSONDecoder()
    
    private let notificationCentre = NotificationCenter.default
    
    // MARK: - Views
    var loginView = LoginView()
    
    let loadingAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("loading")
        animationView.backgroundColor = .backgroundColor
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    let rocketAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("119388-rocket")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.layer.opacity = 0.8
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    let profileView = ProfileView()
    
    let createUserView = CreateUserView()
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "ошибка", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
    
    let movinAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("93693-moving-truck")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.database.delegate = self
        loginView.delegate = self
        createUserView.delegate = self
        setupLoginView(loginView)
        self.view.addGestureRecognizer(tap)
        //        setupProfileView()
        //        setupCreateUserView()
    }
    
    // MARK: - Navigation
    
    // установка логинки
    private func setupLoginView(_ loginView: UIView) {
        self.view.addSubview(loginView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            loginView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            loginView.heightAnchor.constraint(equalToConstant: 480)
        ])
    }
    
    // установка профайла
    private func setupProfileView() {
        self.view.addSubview(profileView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            profileView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            profileView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -inset*2)
        ])
    }
    
    // установка вью создания аккаунта
    private func setupCreateUserView() {
        self.view.addSubview(createUserView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            createUserView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            createUserView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            createUserView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            createUserView.heightAnchor.constraint(equalToConstant: 560)
        ])
        
    }
    
    // установка в движении профайла
    private func movingSetupProfileView() {
        self.view.addSubview(profileView)
        self.view.addSubview(movinAnimationView)
        setupLoading()
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: movinAnimationView.trailingAnchor, constant: inset),
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            profileView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
            profileView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, constant: -inset*2)
        ])
        
        NSLayoutConstraint.activate([
            movinAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            movinAnimationView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor),
            movinAnimationView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2),
            movinAnimationView.heightAnchor.constraint(equalTo: movinAnimationView.widthAnchor)
        ])
        
        let movinOriginalTransform = self.movinAnimationView.transform
        let movinTranslatedTransform = movinOriginalTransform.translatedBy(x: -self.view.layer.bounds.width*1.5, y: 0)
        
        let amimationOriginalTransform = self.movinAnimationView.transform
        let amimationOriginalTranslatedTransform = amimationOriginalTransform.translatedBy(x: -self.view.layer.bounds.width*1.5, y: 0)
        
        UIView.animate(withDuration: 2, delay: 0, options: .transitionFlipFromLeft) {
            self.movinAnimationView.play()
            self.movinAnimationView.transform = movinTranslatedTransform
            self.profileView.transform = amimationOriginalTranslatedTransform
        } completion: { handler in
            print("movinAnimationView was finished. handler - \(handler)")
        }
    }
    
    // установка логинки с анимацией
    private func MovingSetupLoginView() {
        self.view.addSubview(rocketAnimationView)
        self.view.addSubview(loginView)
        
        let inset: CGFloat = 16
        
        
        NSLayoutConstraint.activate([
            rocketAnimationView.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: 100),
            rocketAnimationView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            rocketAnimationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            rocketAnimationView.heightAnchor.constraint(equalTo: rocketAnimationView.widthAnchor )
        ])
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.layer.bounds.height),
            loginView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            loginView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            loginView.heightAnchor.constraint(equalToConstant: 480)
        ])
        
        let loginOriginalTransform = self.loginView.transform
        let loginTranslatedTransform = loginOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        let amimationOriginalTransform = self.rocketAnimationView.transform
        let amimationOriginalTranslatedTransform = amimationOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        
        UIView.animate(withDuration: 3, delay: 0) { [self] in
            rocketAnimationView.play()
            self.loginView.transform = loginTranslatedTransform
            self.rocketAnimationView.transform = amimationOriginalTranslatedTransform
        } completion: { handler in
            print("rocketAnimationView was finished. handler - \(handler)")
        }
    }
    
    private func setupLoading() {
        self.view.addSubview(loadingAnimationView)
        loadingAnimationView.play()
        NSLayoutConstraint.activate([
            loadingAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingAnimationView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //MARK: dismissKeyboardTap
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return tap
    }()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ProfileViewController: LoginViewDelegate {
    func tapLogin() {
        
//        var user: User?
        
        guard let mail = loginView.mailTextField.text else {return}
        
        guard let pass = loginView.passTextField.text else {return}
        
        setupLoading()
        
        loginView.layer.opacity = 0
        print("--- login user")
        Auth.auth().signIn(withEmail: mail, password: pass) {[self] result, error in
            if error != nil {
                alert.message = error?.localizedDescription
                self.present(alert, animated: true, completion: nil)
            } else {
                
                print("--- user authorized")
                database.getUserData(uid: result!.user.uid)
            }
        }
        
        //        let loginOriginalTransform = self.loginView.transform
        //        let loginTranslatedTransform = loginOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        //        let amimationOriginalTransform = self.rocketAnimationView.transform
        //        let amimationOriginalTranslatedTransform = amimationOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        //
        //        UIView.animate(withDuration: 1, delay: 0) { [self] in
        //            rocketAnimationView.play()
        //            self.loginView.transform = loginTranslatedTransform
        //            self.rocketAnimationView.transform = amimationOriginalTranslatedTransform
        //        } completion: { [self] handler in
        //            movingSetupProfileView()
        //            print("rocketAnimationView was finished. handler - \(handler)")
        //        }
    }
    
    func tapStartCreateUser() {
        loginView.layer.opacity = 0
        setupCreateUserView()
    }
    
    func tapResetPassword() {
        
    }
}

extension ProfileViewController: CreateUserViewDelegate {
    func tapCreateUser(firstName: String, lastName: String, nickName: String, mail: String, pass: String) {
        var tempUser = User(firstName: firstName, lastName: lastName, nick: nickName, mail: mail)
        
        Auth.auth().createUser(withEmail: mail, password: pass) { [self] authDataResult, error in
            
            if error != nil {
                alert.message = error?.localizedDescription
                self.present(alert, animated: true, completion: nil)
            } else {
                tempUser.id = authDataResult?.user.uid
                loginView.mailTextField.text = tempUser.mail
                loginView.passTextField.text = pass
                loginView.layer.opacity = 1
                createUserView.layer.opacity = 0
                database.addUser(user: tempUser)
                
            }
        }
    }
}

extension ProfileViewController: DatabaseDelegate {
    func reloadView(competitions: [Competition]) {}
    
    func reloadView(user: User) {
        
        loadingAnimationView.stop()
        setupProfileView()
        profileView.label.text = user.docId
        loginView.layer.opacity = 0
        profileView.setupData(
            nick: user.nick,
            firstName: user.firstName,
            lastName: user.lastName,
            id: user.id!
        )
        
    }
    
    func reloadTableCollectionView() {}
    
    
}
