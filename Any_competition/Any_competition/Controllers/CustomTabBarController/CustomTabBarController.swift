//
//  CustomTabBarController.swift
//  customTabBar
//
//  Created by Mikhail Chuparnov on 21.11.2022.
//

import UIKit
import RxSwift
import SnapKit

class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()
    
    static var user: User?
 
    let database = Database()
    
    let userDefaults = UserDefaults.standard

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
//        getUserData()
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupHierarchy() {
        view.addSubview(customTabBar)
    }
    
    private func setupLayout() {
        customTabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(45)
            $0.height.equalTo(60)
        }
    }
    
    private func setupProperties() {
        self.tabBar.isHidden = true
        
        customTabBar.translatesAutoresizingMaskIntoConstraints = false

        selectedIndex = 0
        let controllers = CustomTabItem.allCases.map {
            $0.viewController
            
        }

        setViewControllers(controllers, animated: true)
    }

    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
    
    //MARK: - Bindings
    
    private func bind() {
        customTabBar.itemTapped
            .bind { [weak self] in self?.selectTabWith(index: $0)
            }
            .disposed(by: disposeBag)
    }
    
//    private func getUserData() {
//        if let uid = userDefaults.object(forKey: "uid") {
//            database.getUserData(uid: uid as! String, isReloadView: false)
//        }
//    }
}
