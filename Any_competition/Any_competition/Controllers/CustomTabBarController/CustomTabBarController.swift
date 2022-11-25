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
}

extension CustomTabBarController: ProfileViewControllerDelegate {
    func closeCustomTabBar() {
        customTabBar.removeFromSuperview()
    }
    
    func setupCustomTabBar() {
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
}
