//
//  StartViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.09.2022.
//

import UIKit

class StartViewController: UIViewController {
    
    var labelView = AnyCompLogoUILabel()
    
    var buttonView = AnyCompUIButton(title: "Начнем игру")
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        buttonView.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        setupController()
    }

    private func setupController() {
        self.view.addSubview(labelView)
        self.view.addSubview(buttonView)
        
    let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            labelView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            labelView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset)
        ])
        
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            buttonView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            buttonView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    @objc func tapButton() {
        
        if let user = ProfileViewController.user {
            let vc = AddCompetitionViewController()
            self.navigationController?.present(vc, animated: true)
        } else {
            alert.message = "необходимо авторизоваться в приложении если есть аккаунт\nили создать предварительно аккаунт"
            self.present(alert, animated: true)
        }
        
        
    }
}

