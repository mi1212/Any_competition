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
        self.view.backgroundColor = .cyan
        buttonView.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        setupController()
    }

    private func setupController() {
        self.view.addSubview(labelView)
        self.view.addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            labelView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            labelView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            buttonView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            buttonView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor)
        ])

    }
    
    @objc func tapButton() {
        let vc = UIViewController()
        vc.view.backgroundColor = .cyan
        vc.title = "dfgdfgdfg"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

