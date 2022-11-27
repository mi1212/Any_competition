//
//  CustomItemView.swift
//  customTabBar
//
//  Created by Mikhail Chuparnov on 21.11.2022.
//

import UIKit
import SnapKit

final class CustomItemView: UIView {

    private let iconImageView = UIImageView()

    let index: Int
    
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    
    private let item: CustomTabItem
    
    init(with item: CustomTabItem, index: Int) {
        self.item = item
        self.index = index
        
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(iconImageView)
        iconImageView.image = isSelected ? item.selectedIcon : item.icon

        iconImageView.snp.makeConstraints { make in
#warning("проблемы с констрейтами")
            make.width.equalTo(36)
            make.height.equalTo(36)
            make.bottom.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    private func animateItems() {
        UIView.transition(with: iconImageView,
                          duration: 0.4,
                          options: .transitionCrossDissolve) { [unowned self] in
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
    }
}
