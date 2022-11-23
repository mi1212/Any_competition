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
    
//    private let movingView = UIView()
    
    private let itemTappedSubject = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    
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
//        addSubview(movingView)
        addSubview(stack)

        stack.addArrangedSubviews([competitionsItem, profileItem])
    }
    
    private func setupLayout() {
        
        stack.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview()
        }

//        movingView.snp.makeConstraints { make in
//            make.top.leading.bottom.equalToSuperview().inset(6)
//            make.width.equalToSuperview().multipliedBy(0.5)
//        }

    }
    
    private func setupProperties() {
        stack.distribution = .fillEqually
        stack.alignment = .center
        
        backgroundColor = .black
        setupCornerRadius(32)
        
//        movingView.backgroundColor = .anyColor
//        movingView.setupCornerRadius(26)
        
        customItemViews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
        }
    }
    
    private func selectItem(index: Int) {
        customItemViews.forEach { $0.isSelected = $0.index == index }
        itemTappedSubject.onNext(index)
    }
    
    //MARK: - Bindings
    
    private func bind() {
        competitionsItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.competitionsItem.animateClick {
                    self.selectItem(index: self.competitionsItem.index)
                    
//                    UIView.transition(with: self.movingView,
//                                      duration: 0.4,
//                                      options: .transitionCrossDissolve) { [unowned self] in
//                        self.movingView.snp.remakeConstraints { make in
//                            make.top.leading.bottom.equalToSuperview().inset(6)
//                            make.width.equalToSuperview().multipliedBy(0.5)
//                        }
//                    }
  
                }
            }
            .disposed(by: disposeBag)

        profileItem.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.profileItem.animateClick {
                    self.selectItem(index: self.profileItem.index)
                    
//                    UIView.transition(with: self.movingView,
//                                      duration: 0.4,
//                                      options: .transitionCrossDissolve) { [unowned self] in
//                        self.movingView.snp.remakeConstraints { make in
//                            make.top.trailing.bottom.equalToSuperview().inset(6)
//                            make.width.equalToSuperview().multipliedBy(0.5)
//                        }
//                    }
 
                }
            }
            .disposed(by: disposeBag)
    }
}
