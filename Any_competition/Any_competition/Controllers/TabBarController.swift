//
//  TabBarController.swift
//  custom tabBar
//
//  Created by Mikhail Chuparnov on 06.07.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        configurateTabBar()
      
        viewControllers = [
            setupTabBar(viewController: ViewController(), title: "add competition", image: "plus"),
            setupTabBar(viewController: ViewController(), title: "competitions", image: "competition") ,
            setupTabBar(viewController: ViewController(), title: "profile", image: "profile")
        ]
        
    }
    
    // сделать табБар прозрачным при скроллинге
    private func configurateTabBar() {
                
        let tabBarAppearance = UITabBarAppearance()

        tabBarAppearance.configureWithTransparentBackground()

        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.tintColor = .black
//        self.tabBar.scrollEdgeAppearance = tabBarAppearance // доступен только на ios 15
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()

        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.compactAppearance = navigationBarAppearance
  
    }
    
    private func setupTabBar(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let vc = UINavigationController(rootViewController: viewController)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: image)
        return vc
    }

    
}
