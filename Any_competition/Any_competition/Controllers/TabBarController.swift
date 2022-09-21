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
        tabBar.backgroundColor = .white
        viewControllers = [
            setupTabBar(viewController: StartViewController(), title: "add competition", image: "plus"),
            setupTabBar(viewController: CompetitionsCollectionViewController(collectionViewLayout: setupflowLayout()), title: "competitions", image: "competition") ,
            setupTabBar(viewController: UIViewController(), title: "profile", image: "profile")
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

    private func setupflowLayout() -> UICollectionViewFlowLayout {
        let inset: CGFloat = 10
        
        let collectionViewlowFLayout: UICollectionViewFlowLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            let width = (self.view.bounds.width - inset*2)/1
            flowLayout.itemSize = CGSize(width: width, height: width/4)
            flowLayout.minimumInteritemSpacing = inset
            flowLayout.minimumLineSpacing = inset
            flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            return flowLayout
        }()
        
        return collectionViewlowFLayout
    }
    
}
