//
//  AddCompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
//import FirebaseAuth
import FirebaseFirestore

class AddCompetitionViewController: UIViewController {
    
//    private let encoder = JSONEncoder()
    
//    private let decoder = JSONDecoder()
    
//    let dataFetcher = CompetitionFetch()
    
    var db = Firestore.firestore()

    let competitionTitleTextField = AnyCompUITextField(placeholder: "Название соревнования")
    
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
        self.view.addSubview(competitionTitleTextField)
        self.view.addSubview(playerQtyTextField)
        self.view.addSubview(typeTextField)
        self.view.addSubview(addButton)
        
        
        let inset: CGFloat = 60
        
        NSLayoutConstraint.activate([
            competitionTitleTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            competitionTitleTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            competitionTitleTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            competitionTitleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            playerQtyTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            playerQtyTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            playerQtyTextField.topAnchor.constraint(equalTo: self.competitionTitleTextField.bottomAnchor, constant: inset/2),
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
        
        var ref: DocumentReference? = nil
        ref = db.collection("competitions").addDocument(data: [
            "title" : competitionTitleTextField.text,
            "qtyPlayers": playerQtyTextField.text,
            "sportType": typeTextField.text
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        print("\(db.collection("competitions"))")
        
        dismiss(animated: true, completion: nil)
    }
    
}
