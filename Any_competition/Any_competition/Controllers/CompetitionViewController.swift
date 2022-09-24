//
//  CompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 24.09.2022.
//

import UIKit

class CompetitionViewController: UIViewController {
    
    var competitionCell: Competition?
    
    let titleLabel = AnyCompUILabel(title: "Title: ")
    
    let qtyPlayersLabel = AnyCompUILabel(title: "qtyPlayers: ")
    
    let typeSportLabel = AnyCompUILabel(title: "typeSport: ")
    
    let dateLabel = AnyCompUILabel(title: "date: ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupController()
        setupLabel()
    }
    
    private func setupController() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(qtyPlayersLabel)
        self.view.addSubview(typeSportLabel)
        self.view.addSubview(dateLabel)
        
        let inset: CGFloat = 60
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            qtyPlayersLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            qtyPlayersLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: inset/2),
            qtyPlayersLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            typeSportLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            typeSportLabel.topAnchor.constraint(equalTo: self.qtyPlayersLabel.bottomAnchor, constant: inset/2),
            typeSportLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            dateLabel.topAnchor.constraint(equalTo: self.typeSportLabel.bottomAnchor, constant: inset/2),
            dateLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupLabel() {
        titleLabel.text! += (competitionCell?.info.title)!
        qtyPlayersLabel.text! += "\((competitionCell?.info.qtyPlayers)!)"
        typeSportLabel.text! += (competitionCell?.info.sportType)!
        
        if let stringDate = (competitionCell?.info.date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            
            if let date = dateFormatter.date(from: stringDate) {
                
                dateLabel.text? = date.formatted(date: .numeric, time: .omitted)
            }
            
        }
    }
    
}
