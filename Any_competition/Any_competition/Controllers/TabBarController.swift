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
        view.backgroundColor = .white
        configurateTabBar()
    }

    private func configurateTabBar() {
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.viewControllers = [
            setupTabBar(viewController: StartViewController(), title: "add competition", image: "plus"),
            setupTabBar(viewController: CompetitionsCollectionViewController(collectionViewLayout: setupflowLayout()), title: "competitions", image: "competition") ,
            setupTabBar(viewController: UIViewController(), title: "profile", image: "profile")
        ]
    }
    
    private func setupTabBar(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let vc = UINavigationController(rootViewController: viewController)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: image)
        return vc
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
    
}