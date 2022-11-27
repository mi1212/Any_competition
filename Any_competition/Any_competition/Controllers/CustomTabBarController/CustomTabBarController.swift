//
//  CustomTabBarController.swift
//  customTabBar
//
//  Created by Mikhail Chuparnov on 21.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CustomTabBarController: UITabBarController {
    
    private let customTabBar = CustomTabBar()

    let userDefaults = UserDefaults.standard
    
    private let disposeBag = DisposeBag()
    
    init(uid: String) {
        super.init(nibName: nil, bundle: nil)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
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
        self.view.backgroundColor = .backgroundColor
        
        customTabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
    }
    
    private func setupProperties() {

        customTabBar.translatesAutoresizingMaskIntoConstraints = false

        selectedIndex = 0
//        let controllers = CustomTabItem.allCases.map {
//            $0.viewController
//            $0.viewController.delegate = self
//        }
        
        let vc1 = CompetitionsViewController()
        vc1.delegate = self
        
        let nc1 = UINavigationController(rootViewController: vc1)
        
        let vc2 = ProfileViewController()
        vc2.delegate = self
        
        let nc2 = UINavigationController(rootViewController: vc2)

        let controllers = [nc1, nc2]
        
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
}

extension CustomTabBarController: ProfileViewControllerDelegate {
    func hideCustomBarFromProfile() {
        let originalTransform = self.customTabBar.transform
        let translatedTransform = originalTransform.translatedBy(x: 0.0, y: 100.0)
        UIView.animate(withDuration: 0.4, animations: {
            self.customTabBar.transform = translatedTransform
        })

    }
    
    func showCustomBarFromProfile() {
        let originalTransform = self.customTabBar.transform
        let translatedTransform = originalTransform.translatedBy(x: 0.0, y: -100)
        UIView.animate(withDuration: 0.4, animations: {
            self.customTabBar.transform = translatedTransform
        })
    }
}

extension CustomTabBarController: CompetitionsViewControllerDelegate {
    func hideCustomBarFromCompetitions() {
        let originalTransform = self.customTabBar.transform
        let translatedTransform = originalTransform.translatedBy(x: 0.0, y: 100.0)
        UIView.animate(withDuration: 0.4, animations: {
            self.customTabBar.transform = translatedTransform
        })
    }
    
    func showCustomBarFromCompetitions() {
        let originalTransform = self.customTabBar.transform
        let translatedTransform = originalTransform.translatedBy(x: 0.0, y: -100)
        UIView.animate(withDuration: 0.4, animations: {
            self.customTabBar.transform = translatedTransform
        })
    }
}
