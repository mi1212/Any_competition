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
    
    private let notificationCentre = NotificationCenter.default
    
    let userDefaults = UserDefaults.standard
    
    let database = Database()
    
    private lazy var scrollView = UIScrollView()

    private lazy var contentView = UIView()
    
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
        self.view.addGestureRecognizer(tap)
        setupView()
        setupProperts()
        addTargetsToButtons()
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
//        scrollView.backgroundColor = .systemPink
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
//            make.centerY.equalTo(scrollView)
            make.leading.trailing.equalTo(scrollView)
            make.width.height.equalTo(scrollView)
//            make.bottom.equalTo(scrollView)
        }
        
        contentView.addSubview(textFieldsStack)
//        contentView.backgroundColor = .blue
        
        textFieldsStack.addArrangedSubviews([mailTextField, passTextField])

        textFieldsStack.snp.makeConstraints { make in
//            make.centerY.equalTo(contentView)
            make.centerY.equalToSuperview()
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        contentView.addSubview(noteLabel)

        noteLabel.snp.makeConstraints { make in
            make.bottom.equalTo(textFieldsStack.snp.top).inset(-48)
            make.leading.trailing.equalTo(contentView).inset(16)
        }
        
        contentView.addSubview(authLabel)

        authLabel.snp.makeConstraints { make in
            make.bottom.equalTo(noteLabel.snp.top).inset(-16)
            make.leading.trailing.equalTo(contentView).inset(16)
        }

        contentView.addSubview(resetPassButton)

        resetPassButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(textFieldsStack.snp.bottom).inset(-16)
        }

        contentView.addSubview(loginButton)

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(resetPassButton.snp.bottom).inset(-48)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }

        contentView.addSubview(createUserStack)

        createUserStack.addArrangedSubviews([createUserLabel, createUserButton])

        createUserStack.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-50)
            make.centerX.equalTo(contentView)
//            make.bottom.equalTo(contentView.snp.bottom).inset(16)
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
        
        createUserButton.setTitleColor(.anyPurpleColor, for: .normal)
        resetPassButton.setTitleColor(.anyPurpleColor, for: .normal)
        createUserButton.setTitleColor(.anyGreenColor, for: .selected)
        resetPassButton.setTitleColor(.anyDarckColor, for: .selected)
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
       
    @objc func tapLoginButton() {
        
        animationTapButton(loginButton)
        
        view.endEditing(true)
        
        guard let mail = self.mailTextField.text else {return}
        
        guard let pass = self.passTextField.text else {return}
        
        let textFieldArray = [mailTextField, passTextField]
        if mail != "" && pass != "" {
            setupLoading()
            Auth.auth().signIn(withEmail: mail, password: pass) {[self] result, error in
                if error != nil {
                    loadingAnimationView.removeFromSuperview()
                    alert.message = error?.localizedDescription
                    self.present(alert, animated: true, completion: nil)
                } else {
                    
                    print("--- user authorized")
                    
                    if let uid = result?.user.uid {

                        userDefaults.set(uid, forKey: "uid")
                        loadingAnimationView.removeFromSuperview()
                        
                        self.mailTextField.text = ""
                        self.passTextField.text = ""
                        
                        let vc = CustomTabBarController(uid: uid)
                        
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
                        
                        print("--- handler was finished with uid = \(uid)")
                    }
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
    
    //MARK: dismissKeyboardTap
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        return tap
    }()
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController {
    
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
            scrollView.contentInset.bottom = kbdSize.height*1.2
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbdSize.height, right: 0)
            print(scrollView.layer.bounds)
        }
    }
    
    @objc private func kbdHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
}
