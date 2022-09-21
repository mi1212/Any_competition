//
//  AddCompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddCompetitionViewController: UIViewController {

    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    let dataFetcher = CompetitionFetch()
    
    var database: Database?
    
    private lazy var databasePath: DatabaseReference? = {
      
        let ref = Database.database().reference().child("competition/")
        
        let autoId = DatabaseReference.childByAutoId(ref)
        
        let refComp = autoId()
 
      return refComp
    }()
    
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
   
            // Возвращает ранее определенный путь к базе данных.
            guard let databasePath = databasePath else {
                return
            }
        print(databasePath)
            // Создает объект Модели user из текста.
        let competition = Competition(id: nil, title: competitionTitleTextField.text!, qtyPlayers: Int(playerQtyTextField.text!)!, sportType: typeTextField.text!)

            do {
                // Кодирует модель user в данные JSON
                let data = try encoder.encode(competition)

                // Преобразует данные JSON в словарь JSON
                let json = try JSONSerialization.jsonObject(with: data)

                //  Записывает словарь в путь к базе данных как дочерний узел с автоматически сгенерированным идентификатором.
                databasePath.setValue(json)
                print(json)
            } catch {
                print("an error occurred", error)

            }
        
        dataFetcher.getData()
//        dismiss(animated: true, completion: nil)
    }

}
