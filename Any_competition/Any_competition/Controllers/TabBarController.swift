//
//  TabBarController.swift
//  custom tabBar
//
//  Created by Mikhail Chuparnov on 06.07.2022.
//

import UIKit
import Lottie

class TabBarController: UITabBarController {
 
    var timer: Timer?

    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupAnimation()
        setupTabBar()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationItem.title = "Profile Settings"
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
        self.tabBar.backgroundColor = .backgroundColor
        self.tabBar.tintColor = .black
        self.viewControllers = [
            setupTabBar(viewController: StartViewController(), title: "add competition", image: "plus"),
            setupTabBar(viewController: CompetitionsCollectionViewController(collectionViewLayout: setupflowLayout()), title: "competitions", image: "competition") ,
            setupTabBar(viewController: ProfileViewController(), title: "profile", image: "profile")
//            setupTabBar(viewController: TestViewController(), title: "profile", image: "profile")
        ]
    }
    
    private func setupTabBar(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(named: image)
        
        return navigationVC
    }
    
        private func setupflowLayout() -> UICollectionViewFlowLayout {
            let inset: CGFloat = 16
    
            let collectionViewlowFLayout: UICollectionViewFlowLayout = {
                let flowLayout = UICollectionViewFlowLayout()
                let width = (self.view.bounds.width - inset*2)/1
                let height = (self.view.bounds.height - inset*8)/7
                flowLayout.itemSize = CGSize(width: width, height: height)
    
                flowLayout.minimumLineSpacing = inset
    
                flowLayout.sectionInset = UIEdgeInsets(top: inset*2, left: inset, bottom: inset*2, right: inset)
                return flowLayout
            }()
    
            return collectionViewlowFLayout
        }    
}





