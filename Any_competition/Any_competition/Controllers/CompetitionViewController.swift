//
//  CompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 24.09.2022.
//

import UIKit
import KRTournamentView

class CompetitionViewController: UIViewController{
   
    var competitionCell: Competition?
    
    let titleLabel = AnyCompUILabel(title: "Title: ")
    
    let qtyPlayersLabel = AnyCompUILabel(title: "qtyPlayers: ")
    
    let typeSportLabel = AnyCompUILabel(title: "typeSport: ")
    
    let dateLabel = AnyCompUILabel(title: "date: ")
    
    var winnerIndexes = [Int]()
    
    private lazy var tournamentView: KRTournamentView = {
        let tournamentView = KRTournamentView()
        tournamentView.backgroundColor = .white
        tournamentView.dataSource = self
        tournamentView.delegate = self
        tournamentView.lineColor = .black
        tournamentView.style = KRTournamentViewStyle.left
        tournamentView.lineWidth = 2
        tournamentView.translatesAutoresizingMaskIntoConstraints = false
        return tournamentView
    }()
    
    private var builder: TournamentBuilder = .init(numberOfLayers: 2)

    private var entryNames = [Int: String]()
    
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
        self.view.addSubview(tournamentView)
        
        let inset: CGFloat = 12
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: inset)
        ])
        
        NSLayoutConstraint.activate([
            qtyPlayersLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            qtyPlayersLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: inset/2),
            qtyPlayersLabel.heightAnchor.constraint(equalToConstant: inset)
        ])
        
        NSLayoutConstraint.activate([
            typeSportLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            typeSportLabel.topAnchor.constraint(equalTo: self.qtyPlayersLabel.bottomAnchor, constant: inset/2),
            typeSportLabel.heightAnchor.constraint(equalToConstant: inset)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            dateLabel.topAnchor.constraint(equalTo: self.typeSportLabel.bottomAnchor, constant: inset/2),
            dateLabel.heightAnchor.constraint(equalToConstant: inset)
        ])
        
        NSLayoutConstraint.activate([
            tournamentView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: inset/2),
            tournamentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            tournamentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            tournamentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -inset)
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

extension CompetitionViewController: KRTournamentViewDataSource {
    func entrySize(in tournamentView: KRTournamentView) -> CGSize {
        CGSize(width: 80, height: 40)
    }
    
    func structure(of tournamentView: KRTournamentView) -> Bracket {
        return builder.build(format: true)
    }
    
    func tournamentView(_ tournamentView: KRTournamentView, entryAt index: Int) -> KRTournamentViewEntry {
        let entry = KRTournamentViewEntry()
        
//        entry.textLabel.text = (competitionCell?.players[index].name)! + " " + (competitionCell?.players[index].secondName)!
        
        entry.textLabel.text = "player \(index)"
        
        let font = UIFont(name: "Press Start 2P", size: UIFont.systemFontSize.nextDown)
        
        entry.textLabel.font = font
     
        return entry
    }
    
    func tournamentView(_ tournamentView: KRTournamentView, matchAt matchPath: MatchPath) -> KRTournamentViewMatch {
        MyMatch()
    }
}

extension CompetitionViewController: KRTournamentViewDelegate {
    
    func tournamentView(_ tournamentView: KRTournamentView, didSelectEntryAt index: Int) {
        winnerIndexes.append(index)
        builder.setWinnerIndexes(winnerIndexes)
        tournamentView.reloadData()
    }
    
    func tournamentView(_ tournamentView: KRTournamentView, didSelectMatchAt matchPath: MatchPath) {
        print("didSelectMatchAt\(matchPath)")
    }
}
