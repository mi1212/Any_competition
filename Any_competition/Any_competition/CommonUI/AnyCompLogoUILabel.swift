//
//  AnyCompLogoUILabel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 05.10.2022.
//

import UIKit

class AnyCompLogoUILabel: UILabel {
   
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        super.init(frame: .zero)
        
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func configure() {
        self.text = "Any_competition"
        self.font = UIFont.anyCompFont.withSize(18)
        self.adjustsFontForContentSizeCategory = true
        self.numberOfLines = 0
        self.textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
}
