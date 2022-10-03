//
//  AnyCompUILabel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.09.2022.
//

import UIKit

class AnyCompUILabel: UILabel {
   
    
    enum FontSize: CGFloat {
        case large = 24
        case medium = 18
        case small = 8
            }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(title: String, fontSize: AnyCompUILabel.FontSize) {
        super.init(frame: .zero)
        self.text = title
        configure(fontSize: fontSize.rawValue)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func configure(fontSize: AnyCompUILabel.FontSize.RawValue) {
        
        self.font = UIFont.anyCompLargeFont.withSize(fontSize)
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 0
        self.textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
