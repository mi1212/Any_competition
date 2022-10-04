//
//  TestViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 04.10.2022.
//

import UIKit
import Lottie

class TestViewController: UIViewController {

    var timer: Timer?
    
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupAnimation()
        setupTabBar()
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("darts2")
        animationView.frame = view.bounds
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.play()
        self.view.addSubview(animationView)
    }
    
    private func setupTabBar() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
            let tc = TabBarController()
            self.navigationController?.pushViewController(tc, animated: true)
        })
    }
    
}
