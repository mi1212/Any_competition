//
//  TestViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 04.10.2022.
//

import UIKit
import Lottie

class TestViewController: UIViewController {
    
    let rocketAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("119388-rocket")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    let button = AnyCompUIButton(title: "tap")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
       
        self.view.addSubview(rocketAnimationView)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            rocketAnimationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            rocketAnimationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            rocketAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -inset),
            rocketAnimationView.heightAnchor.constraint(equalTo: rocketAnimationView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: inset),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -inset),
            button.heightAnchor.constraint(equalToConstant: 64),
            button.topAnchor.constraint(equalTo: rocketAnimationView.bottomAnchor, constant: inset)
        ])
    }
    
    @objc func tapButton() {
        
        UIView.animate(withDuration: 1, delay: 5) {
            print("start")
            self.rocketAnimationView.layer.opacity = 0
        } completion: { handler in
            print("finish")
            print(handler)
        }

    }
        
}
