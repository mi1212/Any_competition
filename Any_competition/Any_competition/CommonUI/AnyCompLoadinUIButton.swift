//
//  AnyCompLoadinUIButton.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 03.11.2022.
//

//
//  LoaderButton.swift
//

import UIKit

class AnyCompLoadinUIButton: UIButton {

    var spinner = UIActivityIndicatorView()

    var isLoading = false {
        didSet {
            updateView()
        }
    }
    
    
    public init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        configure()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func configure() {
        self.backgroundColor = .anyColor
        self.layer.cornerRadius = 24
        self.clipsToBounds = true
        self.titleLabel?.font =  UIFont.systemFont(ofSize: UIFont.buttonFontSize, weight: .regular)
        self.setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupView() {
        spinner.hidesWhenStopped = true
        spinner.color = UIColor.anyDarckColor
        spinner.style = .large
        
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func updateView() {
        if isLoading {
            spinner.startAnimating()
            titleLabel?.alpha = 0
            imageView?.alpha = 0
            isEnabled = false
        } else {
            spinner.stopAnimating()
            titleLabel?.alpha = 1
            imageView?.alpha = 0
            isEnabled = true
        }
    }
}
