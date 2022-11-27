//
//  SettingsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 16.11.2022.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    let label = AnyCompLogoUILabel()
    let exitButton = AnyCompUIButton(title: "Выйти из аккаунта")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(label)
        self.view.addSubview(exitButton)
        exitButton.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        label.text = "Настройки"
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        exitButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    @objc func tapExitButton() {
        animationTapButton(exitButton)
        userDefaults.set(nil, forKey: "uid")
        let vc = UINavigationController(rootViewController: LoginViewController())
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
}
