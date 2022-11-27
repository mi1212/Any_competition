//
//  StartAnimationViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 27.11.2022.
//

import UIKit
import Lottie
import SnapKit

class StartAnimationViewController: UIViewController {
    
    let logoLabel = AnyCompLogoUILabel()
    
    let animationView = AnimationView()
    
    let userDefaults = UserDefaults.standard
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupProperties()
        setupViews()
        setupAnimation()
        setupMainViewController()
    }
    
    private func setupViews() {
        view.addSubview(animationView)
        view.addSubview(logoLabel)
        
        animationView.snp.makeConstraints { make in
            
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(animationView.snp.width).multipliedBy(1.5)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        logoLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview()
            make.leading.equalTo(animationView.snp.trailing).inset(32)
        }
    }
    
    private func setupProperties() {
        logoLabel.text = "competition"
        logoLabel.numberOfLines = 1
        logoLabel.textAlignment = .left
        logoLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("darts2")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        
    }
    
    private func setupMainViewController() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false, block: { _ in
            if let uid = self.userDefaults.object(forKey: "uid") {
                let vc = UINavigationController(rootViewController: CustomTabBarController(uid: uid as! String))
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
            } else {
                let vc = UINavigationController(rootViewController: LoginViewController())
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
            }
            self.animationView.layer.opacity = 0
            self.animationView.removeFromSuperview()
        })
    }

}
