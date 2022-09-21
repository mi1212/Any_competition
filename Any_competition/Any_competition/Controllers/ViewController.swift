//
//  ViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var labelView = AnyCompUILabel(title: "Во что будем играть?")
    
    var buttonView = AnyCompUIButton(title: "Начнем игру")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        buttonView.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        setupController()
    }

    private func setupController() {
        self.view.addSubview(labelView)
        self.view.addSubview(buttonView)
        
    let inset: CGFloat = 30
        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            labelView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            labelView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset)
        ])
        
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            buttonView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            buttonView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    @objc func tapButton() {
        let vc = UIViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

