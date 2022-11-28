//
//  StatisticView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 24.11.2022.
//

import UIKit
import SnapKit

class StatisticView: UIView {
    
    let imageView = UIImageView()
    
    let nameLabel = AnyCompUILabel(title: "", fontSize: .small)
    
    let qtyLabel = AnyCompUILabel(title: "", fontSize: .medium)

    convenience init(imageViewName: String, name: String, qty: String) {
        self.init()
        self.imageView.image = UIImage(named: imageViewName)
        self.nameLabel.text = name
        self.qtyLabel.text = qty
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(qtyLabel)
//        imageView.backgroundColor = .green
//        nameLabel.backgroundColor = .blue
//        qtyLabel.backgroundColor = .purple
        
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
            make.bottom.equalTo(nameLabel.snp.top).inset(-8)
            make.width.equalTo(imageView.snp.height)
            make.centerX.equalToSuperview()
        }

        qtyLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
//            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
    }
}
