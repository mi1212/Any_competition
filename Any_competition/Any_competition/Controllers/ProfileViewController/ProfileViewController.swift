//
//  ProfileViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit
import Lottie
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    static var user: User?
    
    let database = Database()
    
    private let decoder = JSONDecoder()
    
    private let notificationCentre = NotificationCenter.default
    
    // MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    var loginView = LoginView()
    
    let profileView = ProfileView()
    
    let createUserView = CreateUserView()
    
    let addPlayerView = AddPlayerView()
    
    let loadingAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("loading")
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "ошибка", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.database.delegate = self
        loginView.delegate = self
        createUserView.delegate = self
        profileView.delegate = self
        profileView.friendsView.delegate = self
        checkLogin()
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Navigation
   
    // установка вьюх если нужно залогиниться
    private func setupViewsToLogin() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        contentView.addSubview(loginView)
        contentView.addSubview(createUserView)
        contentView.addSubview(profileView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
      
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: contentView.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createUserView.topAnchor.constraint(equalTo: contentView.topAnchor),
            createUserView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor),
            createUserView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            createUserView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -inset),
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -2*inset),
            profileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // установка вьюх если не нужно залогиниться
    private func setupViewsWithoutLogin() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(loginView)
        contentView.addSubview(profileView)
        contentView.addSubview(createUserView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
      
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        ])

        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: contentView.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loginView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            loginView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createUserView.topAnchor.constraint(equalTo: contentView.topAnchor),
            createUserView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor),
            createUserView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            createUserView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -2*inset),
            profileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupAddPlayerView() {
        self.view.addSubview(addPlayerView)
//        addPlayerView.delegate = self
        
        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            addPlayerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            addPlayerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            addPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            addPlayerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
        ])
        
        addPlayerView.layer.opacity = 0.2
        addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
            addPlayerView.layer.opacity = 1
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
        } completion: { [self] _ in
            addPlayerView.layer.opacity = 1
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1, y: 1)
        }

    }
    
    // функция проверки логина
    private func checkLogin() {
        switch userDefaults.object(forKey: "uid") {
        case nil:
            setupViewsToLogin()
        default:
            if userDefaults.object(forKey: "uid") != nil {
                database.getUserData(uid: userDefaults.object(forKey: "uid") as! String, isReloadView: false)
                setupLoading()
            }
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
    
    //MARK: - dismissKeyboardTap
    
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
        view.endEditing(true)
        guard let mail = loginView.mailTextField.text else {return}

        guard let pass = loginView.passTextField.text else {return}
        
        setupLoading()
        
        Auth.auth().signIn(withEmail: mail, password: pass) {[self] result, error in
            if error != nil {
                loadingAnimationView.removeFromSuperview()
                alert.message = error?.localizedDescription
                self.present(alert, animated: true, completion: nil)
            } else {
                print("--- user authorized")
                userDefaults.set(result!.user.uid, forKey: "uid")
                database.getUserData(uid: result!.user.uid, isReloadView: true)
                UIView.animate(withDuration: 1, delay: 0) { [self] in

                    loginView.transform = loginView.transform.translatedBy(x: self.view.layer.bounds.width, y: 0)
                } completion: { [self] handler in
                    loginView.mailTextField.text = ""
                    loginView.passTextField.text = ""
                    print("handler was finished - \(handler)")
                }
            }
        }
    }
    
    func tapStartCreateUser() {
       print("tapStartCreateUserDelegate")
        view.endEditing(true)
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            loginView.transform = loginView.transform.scaledBy(x: 0.9, y: 0.9)
            loginView.layer.opacity = 0.6
            createUserView.transform = createUserView.transform.translatedBy(x: -self.view.layer.bounds.width, y: 0)
        } completion: { handler in
        }
    }
    
    func tapResetPassword() {}
}

extension ProfileViewController: CreateUserViewDelegate {
    
    func tapCancelButton() {
        
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            loginView.transform = loginView.transform.scaledBy(x: 1/0.9, y: 1/0.9)
            loginView.layer.opacity = 1
            createUserView.transform = createUserView.transform.translatedBy(x: self.view.layer.bounds.width, y: 0)
        } completion: { handler in
        }
        
    }
    
    func tapCreateUser(firstName: String, lastName: String, nickName: String, mail: String, pass: String) {
        
        var tempUser = User(firstName: firstName, lastName: lastName, nick: nickName)
        
        Auth.auth().createUser(withEmail: mail, password: pass) { [self] authDataResult, error in
            
            if error != nil {
                loadingAnimationView.removeFromSuperview()
                alert.message = error?.localizedDescription
                self.present(alert, animated: true, completion: nil)
            } else {
                tempUser.id = (authDataResult?.user.uid)!
                loginView.layer.opacity = 1
                loginView.mailTextField.text = tempUser.mail
                loginView.passTextField.text = pass
                database.addUser(user: tempUser)
                UIView.animate(withDuration: 1, delay: 0) { [self] in
                    loginView.transform = loginView.transform.scaledBy(x: 1/0.9, y: 1/0.9)
                    createUserView.transform = createUserView.transform.translatedBy(x: self.view.layer.bounds.width, y: 0)
                } completion: { handler in
                }
            }
        }
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    func exitFromProfileView() {
        
        ProfileViewController.user = nil
        database.removeListenerToCompetitionCollection()
        userDefaults.set(nil, forKey: "uid")
        CompetitionsViewController.isAddedListener = false
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            loginView.transform = loginView.transform.translatedBy(x: -self.view.layer.bounds.width, y: 0)
            profileView.transform = profileView.transform.translatedBy(x: -self.view.layer.bounds.width, y: 0)
        } completion: { _ in
            
        }
    }
}

extension ProfileViewController: DatabaseDelegate {
    func receivedAllUsers(users: [User]) {
        
    }
    
        
    func reloadViewWithoutAnimate(user: User) {
        ProfileViewController.user = user
        loadingAnimationView.stop()
        loadingAnimationView.layer.opacity = 0
        setupViewsWithoutLogin()
        profileView.user = user
//        profileView.setupData(user: ProfileViewController.user!)
    }
    
    func animateAndReloadView(user: User) {
        ProfileViewController.user = user

        profileView.setupData(user: user)
        
        loadingAnimationView.removeFromSuperview()
        
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            profileView.transform = profileView.transform.translatedBy(x: self.view.layer.bounds.width, y: 0)
        }
    }
    
    func alertMessage(alertMessage: String) {
        loadingAnimationView.removeFromSuperview()
        alert.message = alertMessage
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadView(competitions: [Competition]) {}
    
    func reloadTableCollectionView() {}
    
}

// MARK: - Keyboard
// сдвигает вью вверх если клавиатура перекрывает выделенное поле ввода
extension ProfileViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCentre.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCentre.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}

extension ProfileViewController: FriendsCollectionViewDelegate {
    func tapAddFriendButton() {
        let vc = FindToAddUserViewController()
        self.navigationController?.present(vc, animated: true)
    }
}

extension ProfileViewController: AddPlayerViewDelegate {
    func tapAddButton(player: User) {}
    
    func tapCancelButtonAddPlayerView() {
        UIView.animate(withDuration: 0.2, delay: 0) { [self] in
            addPlayerView.layer.opacity = 0.2
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 0.2, y: 0.2)
        } completion: { [self] _ in
            addPlayerView.removeFromSuperview()
            addPlayerView.layer.opacity = 1
            addPlayerView.transform = addPlayerView.transform.scaledBy(x: 1/0.2, y: 1/0.2)
        }
    }
}
