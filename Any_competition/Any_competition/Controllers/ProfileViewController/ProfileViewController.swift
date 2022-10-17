//
//  ProfileViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.10.2022.
//

import UIKit
import Lottie

class ProfileViewController: UIViewController {

    let loginView = LoginView()
    
    let animationView: AnimationView = {
        let animationView = AnimationView()
//        animationView.animation = Animation.named("35201-rocket-launch")
//        animationView.animation = Animation.named("68087-rocket")
        animationView.animation = Animation.named("119388-rocket")
//        animationView.backgroundColor = .black
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .playOnce
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        loginView.delegate = self
        setupLoginView()
    }
    
    private func setupLoginView() {
        self.view.addSubview(animationView)
        self.view.addSubview(loginView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            animationView.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: 100),
            animationView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            animationView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor )
        ])

        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.layer.bounds.height),
            loginView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            loginView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
//            loginView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset*3),
//            loginView.heightAnchor.constraint(equalToConstant: super.view.layer.bounds.height/2.2)
            loginView.heightAnchor.constraint(equalToConstant: 340)
        ])
        
        
        
        let loginOriginalTransform = self.loginView.transform
        let loginTranslatedTransform = loginOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        let amimationOriginalTransform = self.animationView.transform
        let amimationOriginalTranslatedTransform = amimationOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        
        UIView.animate(withDuration: 2, delay: 0) { [self] in
            animationView.play()
            self.loginView.transform = loginTranslatedTransform
            self.animationView.transform = amimationOriginalTranslatedTransform
//            animationView.stop()
//            loginView.layer.opacity = 0
        }
    }

    // MARK: - Navigation


}
extension ProfileViewController: LoginViewDelegate {
    func disappeare() {
        
        let loginOriginalTransform = self.loginView.transform
        let loginTranslatedTransform = loginOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        let amimationOriginalTransform = self.animationView.transform
        let amimationOriginalTranslatedTransform = amimationOriginalTransform.translatedBy(x: 0.0, y: -self.view.layer.bounds.height)
        
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            animationView.play()
            self.loginView.transform = loginTranslatedTransform
            self.animationView.transform = amimationOriginalTranslatedTransform
//            animationView.stop()
//            loginView.layer.opacity = 0
        }
    }
    
    
}
