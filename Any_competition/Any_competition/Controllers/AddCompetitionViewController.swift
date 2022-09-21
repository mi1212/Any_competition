//
//  AddCompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit

class AddCompetitionViewController: UIViewController {

    let competitionNameTextField = AnyCompUITextField(placeholder: "Название соревнования")
    
    let playerQtyTextField = AnyCompUITextField(placeholder: "Количество участников")
    
    let typeTextField = AnyCompUITextField(placeholder: "Вид спорта")
    
    @objc let addButton = AnyCompUIButton(title: "Создать соревнование")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupController()
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
    }
    
    private func setupController() {
        self.view.addSubview(competitionNameTextField)
        self.view.addSubview(playerQtyTextField)
        self.view.addSubview(typeTextField)
        self.view.addSubview(addButton)
        
        
    let inset: CGFloat = 60
        
        NSLayoutConstraint.activate([
            competitionNameTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            competitionNameTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            competitionNameTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            competitionNameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            playerQtyTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            playerQtyTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            playerQtyTextField.topAnchor.constraint(equalTo: self.competitionNameTextField.bottomAnchor, constant: inset/2),
            playerQtyTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            typeTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            typeTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            typeTextField.topAnchor.constraint(equalTo: self.playerQtyTextField.bottomAnchor, constant: inset/2),
            typeTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.typeTextField.bottomAnchor, constant: inset/2),
            addButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            addButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func tapAddButton() {
        print("add competition")
        dismiss(animated: true, completion: nil)
    }

}
