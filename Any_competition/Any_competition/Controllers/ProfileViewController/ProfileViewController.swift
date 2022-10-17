//
//  ProfileViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        loginView.delegate = self
        setupLoginView()
    }
    
    private func setupLoginView() {
        self.view.addSubview(loginView)

        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.layer.bounds.height),
            loginView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            loginView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
//            loginView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset*3),
//            loginView.heightAnchor.constraint(equalToConstant: super.view.layer.bounds.height/2.2)
            loginView.heightAnchor.constraint(equalToConstant: 340)
        ])
        
        let originalTransform = self.loginView.transform
        let scaledAndTranslatedTransform = originalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            self.loginView.transform = scaledAndTranslatedTransform
//            loginView.layer.opacity = 0
        }
    }

    // MARK: - Navigation


}
extension ProfileViewController: LoginViewDelegate {
    func disappeare() {
        
        let originalTransform = self.loginView.transform
        let scaledAndTranslatedTransform = originalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            self.loginView.transform = scaledAndTranslatedTransform
//            loginView.layer.opacity = 0
        }
    }
    
    
}
