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
        view.backgroundColor = .backgroundColor
        configurateTabBar()
        fontFamilyName()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.navigationItem.title = "Profile Settings"
    }

    private func configurateTabBar() {
        self.tabBar.backgroundColor = .backgroundColor
        self.tabBar.tintColor = .black
        self.viewControllers = [
            setupTabBar(viewController: StartViewController(), title: "add competition", image: "plus"),
            setupTabBar(viewController: CompetitionsCollectionViewController(collectionViewLayout: setupflowLayout()), title: "competitions", image: "competition") ,
            setupTabBar(viewController: UIViewController(), title: "profile", image: "profile")
        ]
    }
    
    private func setupTabBar(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: viewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(named: image)
        
        return navigationVC
    }

    private func setupflowLayout() -> UICollectionViewFlowLayout {
        let inset: CGFloat = 10
        
        let collectionViewlowFLayout: UICollectionViewFlowLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            let width = (self.view.bounds.width - inset*2)/1
            flowLayout.itemSize = CGSize(width: width, height: width/6)
            
            flowLayout.minimumLineSpacing = inset
            
            flowLayout.sectionInset = UIEdgeInsets(top: inset*2, left: inset, bottom: inset*2, right: inset)
            return flowLayout
        }()
        
        return collectionViewlowFLayout
    }
    
    private func fontFamilyName() {
        for family: String in UIFont.familyNames
                {
                    print(family)
                    for names: String in UIFont.fontNames(forFamilyName: family)
                    {
                        print("== \(names)")
                    }
                }
    }
    
}
