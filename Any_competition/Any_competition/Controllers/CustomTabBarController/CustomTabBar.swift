//
//  CustomTabBar.swift
//  customTabBar
//
//  Created by Mikhail Chuparnov on 21.11.2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SnapKit

final class CustomTabBar: UIView {
    
    let stack = UIStackView()
    
    var itemTapped: Observable<Int> { itemTappedSubject.asObservable() }
    
    private lazy var customItemViews: [CustomItemView] = [competitionsItem, profileItem]
    
    private let competitionsItem = CustomItemView(with: .competitions, index: 0)
    private let profileItem = CustomItemView(with: .profile, index: 1)
    
    private let movingView = UIView()
    
    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    
    var selectedItemIndex: Int?
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupProperties()
        setupLayout()
        bind()
        
        setNeedsLayout()
        layoutIfNeeded()
        selectItem(index: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(movingView)
        addSubview(stack)
        
        stack.addArrangedSubviews([competitionsItem, profileItem])
    }
    
    private func setupLayout() {
        
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }
        
        movingView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(3)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
    }
    
    private func setupProperties() {
        stack.distribution = .fillEqually
        stack.alignment = .center
        
        backgroundColor = .black
        setupCornerRadius(30)
        
        movingView.backgroundColor = .anyPurpleColor
        movingView.setupCornerRadius(26)
        
        customItemViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
        selectedItemIndex = index
    }
    
    //MARK: - Bindings
    
    private func bind() {
        competitionsItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.competitionsItem.animateClick {
                    if self.selectedItemIndex != 0 {
                        let originalTransform = self.movingView.transform
                        let translatedTransform = originalTransform.translatedBy(x: -(self.layer.bounds.width/2 - 6), y: 0)
                        UIView.animate(withDuration: 0.2, animations: {
                            self.movingView.transform = translatedTransform
                        })
                    }
                    self.selectItem(index: self.competitionsItem.index)
                    
                }
            }
            .disposed(by: disposeBag)
        
        profileItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.profileItem.animateClick {
                    if self.selectedItemIndex != 1 {
                        let originalTransform = self.movingView.transform
                        let translatedTransform = originalTransform.translatedBy(x: (self.layer.bounds.width/2 - 6), y: 0)
                        UIView.animate(withDuration: 0.2, animations: {
                            self.movingView.transform = translatedTransform
                        })
                    }
                    self.selectItem(index: self.profileItem.index)
                }
            }
            .disposed(by: disposeBag)
    }
}
