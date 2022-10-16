//
//  AddCompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit

class AddCompetitionViewController: UIViewController {

    let competitionTitleTextField = AnyCompUITextField(placeholder: "Название соревнования", isSecure: false)
    
    let playerQtyTextField = AnyCompUITextField(placeholder: "Количество участников", isSecure: false)
    
    let typeTextField = AnyCompUITextField(placeholder: "Вид спорта", isSecure: false)
    
    let addButton = AnyCompUIButton(title: "Добавить игроков")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        setupController()
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
    }
    
    private func setupController() {
        self.view.addSubview(competitionTitleTextField)
        self.view.addSubview(playerQtyTextField)
        self.view.addSubview(typeTextField)
        self.view.addSubview(addButton)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            competitionTitleTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            competitionTitleTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            competitionTitleTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset*3),
            competitionTitleTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            playerQtyTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            playerQtyTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            playerQtyTextField.topAnchor.constraint(equalTo: self.competitionTitleTextField.bottomAnchor, constant: inset),
            playerQtyTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            typeTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            typeTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            typeTextField.topAnchor.constraint(equalTo: self.playerQtyTextField.bottomAnchor, constant: inset),
            typeTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.typeTextField.bottomAnchor, constant: inset*2),
            addButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            addButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            addButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    @objc func tapAddButton() {
        
        let vc = ConfigurateCompetitionViewController()
        vc.competitionTitle = competitionTitleTextField.text
        vc.playerQty = Int(playerQtyTextField.text!)
        vc.sportType = typeTextField.text
        vc.delegate = self
        self.present(vc, animated: true)        
    }
}

extension AddCompetitionViewController: ConfigurateCompetitionViewControllerDelegate {
    func dismissController() {
        dismiss(animated: true, completion: nil)
    }
}
