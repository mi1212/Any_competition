//
//  CompetitionNetView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 28.09.2022.
//

import UIKit

class CompetitionNetView: UIView {
    
    var competitionTable: CompetitionTable?


    convenience init(competitionTable: CompetitionTable) {
        self.init()
        self.backgroundColor = .backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
//        self.addSubview(tournamentView)
//
//        NSLayoutConstraint.activate([
//            tournamentView.topAnchor.constraint(equalTo: self.topAnchor),
//            tournamentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            tournamentView.widthAnchor.constraint(equalTo: self.widthAnchor),
//            tournamentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//        ])
    }
    
    func reloadData() {
    }
    
}
