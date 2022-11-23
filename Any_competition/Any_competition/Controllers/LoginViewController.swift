//
//  LoginViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 23.11.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import Lottie

class LoginViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    let database = Database()
    
    let authLabel = AnyCompLogoUILabel()
    
    let noteLabel = AnyCompUILabel(title: "Войдите в аккаунт, чтобы начать играть", fontSize: .medium)
    
    let textFieldsStack = UIStackView()
    
    let mailTextField = AnyCompUITextField(placeholder: "введите почту", isSecure: false)
    
    let passTextField = AnyCompUITextField(placeholder: "введите пароль", isSecure: true)
    
    let resetPassButton = AnyCompClearUIButton(title: "Забыли пароль")
    
    let loginButton = AnyCompUIButton(title: "Войти")
    
    let createUserStack = UIStackView()
    
    let createUserLabel = AnyCompUILabel(title: "Нет аккаунта?", fontSize: .medium)
    
    let createUserButton = AnyCompClearUIButton(title: "Создать")
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupView()
        setupProperts()
        addTargetsToButtons()
        addObserverToUserDatabase()
    }
    
    private func setupView() {
        
        view.addSubview(textFieldsStack)
        
        textFieldsStack.addArrangedSubviews([mailTextField, passTextField])
        
        textFieldsStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(noteLabel)
        
        noteLabel.snp.makeConstraints { make in
            make.bottom.equalTo(textFieldsStack.snp.top).inset(-48)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(authLabel)
        
        authLabel.snp.makeConstraints { make in
            make.bottom.equalTo(noteLabel.snp.top).inset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(resetPassButton)
        
        resetPassButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(textFieldsStack.snp.bottom).inset(-16)
        }
        
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(resetPassButton.snp.bottom).inset(-48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        view.addSubview(createUserStack)
        
        createUserStack.addArrangedSubviews([createUserLabel, createUserButton])
        
        createUserStack.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-140)
            make.centerX.equalToSuperview()
        }
        
    }
    
    private func setupProperts() {
        authLabel.text = "Пожалуйста авторизуйтесь"
        authLabel.textAlignment = .left
        
        noteLabel.textAlignment = .left
        
        textFieldsStack.spacing = 16
        textFieldsStack.axis = .vertical
        textFieldsStack.distribution = .fillEqually
        
        createUserStack.spacing = 16
        createUserStack.axis = .horizontal
        createUserStack.distribution = .equalSpacing
        
        mailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
    }
    
    private func addTargetsToButtons() {
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        createUserButton.addTarget(self, action: #selector(tapCreateUserButton), for: .touchUpInside)
        resetPassButton.addTarget(self, action: #selector(tapResetPassButton), for: .touchUpInside)
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
    
    func addObserverToUserDatabase() {
        database.userDatabase.subscribe { [self] user in
            loadingAnimationView.removeFromSuperview()
            self.mailTextField.text = ""
            self.passTextField.text = ""
            let vc = CustomTabBarController(user: user)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func tapLoginButton() {
        setupLoading()
        animationTapButton(loginButton)
        
        view.endEditing(true)
        
        guard let mail = self.mailTextField.text else {return}
        
        guard let pass = self.passTextField.text else {return}
        
        let textFieldArray = [mailTextField, passTextField]
        if mail != "" && pass != "" {
            Auth.auth().signIn(withEmail: mail, password: pass) {[self] result, error in
                if error != nil {
                    loadingAnimationView.removeFromSuperview()
                    alert.message = error?.localizedDescription
                    self.present(alert, animated: true, completion: nil)
                } else {
                    
                    print("--- user authorized")
                    
                    if let uid = result?.user.uid {
#warning("надо разобраться с сохранением в userDefaults")
//                                            userDefaults.set(uid, forKey: "uid")
                                            database.getUserData(uid: uid)
                        
                        print("--- handler was finished with uid = \(uid)")
                    }
                    
//                    self.mailTextField.text = ""
//                    self.passTextField.text = ""
                    
                }
            }
        } else {
            let _: [()] = textFieldArray.map {
                shakeTextFieldifEmpty($0)
            }
            
        }
        
    }
    
    
    @objc func tapCreateUserButton() {
        animationTapButton(createUserButton)
        view.endEditing(true)
        let vc = CreateUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func tapResetPassButton() {
        animationTapButton(resetPassButton)
    }
}
