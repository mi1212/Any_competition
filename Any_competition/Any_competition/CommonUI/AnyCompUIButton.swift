//
//  AnyCompUIButton.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.09.2022.
//

import UIKit

class AnyCompUIButton: UIButton {
    
    let backView = UIView(frame: CGRect(x: 3, y: 3, width: 130, height: 30))
    
    
//    let yourView = UIView()
//    yourView.layer.shadowColor = UIColor.black.cgColor
//    yourView.layer.shadowOpacity = 1
//    yourView.layer.shadowOffset = .zero
//    yourView.layer.shadowRadius = 10
//    yourView.layer.shadowPath = UIBezierPath(rect: yourView.bounds).cgPath
//    yourView.layer.shouldRasterize = true
//    yourView.layer.rasterizationScale = UIScreen.main.scale
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    private func configure() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 3
        self.titleLabel?.font =  .anyCompMediumFont
        self.setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

