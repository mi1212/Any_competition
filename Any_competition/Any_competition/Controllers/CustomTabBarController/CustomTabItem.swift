//
//  CustomTabItem.swift
//  customTabBar
//
//  Created by Mikhail Chuparnov on 21.11.2022.
//

import UIKit

enum CustomTabItem: String, CaseIterable {
    case competitions
    case profile
    
}

extension CustomTabItem {
    
    var viewController: UIViewController {
        switch self {
        case .competitions:
            let nc = UINavigationController(rootViewController: CompetitionViewController())
            
            
            return nc
        case .profile:
            let nc = UINavigationController(rootViewController: ProfileViewController())
            
            
            return nc
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .competitions:
            return UIImage(named: "competitions")?.withTintColor(.white.withAlphaComponent(0.4))
        case .profile:
            return UIImage(named: "profile")?.withTintColor(.white.withAlphaComponent(0.4))
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .competitions:
            return UIImage(named: "competitions")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .profile:
            return UIImage(named: "profile")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            
        }
    }
    
    var name: String {
        return self.rawValue
    }
}
