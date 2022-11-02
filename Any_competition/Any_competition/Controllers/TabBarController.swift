//
//  TabBarController.swift
//  custom tabBar
//
//  Created by Mikhail Chuparnov on 06.07.2022.
//

import UIKit
import Lottie

class TabBarController: UITabBarController {
    
    static var user: User?
 
    let database = Database()
    
    let userDefaults = UserDefaults.standard
    
    var timer: Timer?

    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        getUserData()
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
            self.configurateTabBar()
            self.animationView.layer.opacity = 0
            self.animationView.removeFromSuperview()
        })
    }

    private func configurateTabBar() {
        self.tabBar.backgroundColor = .clear
        self.tabBar.tintColor = .anyDarckColor
        self.viewControllers = [
//            setupTabBar(
//                viewController: CompetitionsViewController(),
//                title: "competitions",
//                image: "ic_car"
//            ),
            setupTabBar(
                viewController: TestViewController(),
                title: "competitions",
                image: "ic_car"
            ),
            setupTabBar(
                viewController: ProfileViewController(),
                title: "profile",
                image: "profile"
            )
        ]

    }
    
    private func setupTabBar(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(named: image)
        return navigationVC
    }
    
    private func getUserData() {
        if let uid = userDefaults.object(forKey: "uid") {
            database.getUserData(uid: uid as! String, isReloadView: false)
        }
    }
    
}





