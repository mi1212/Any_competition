//
//  CompetitionNetView.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 28.09.2022.
//

import UIKit
import KRTournamentView

class CompetitionNetView: UIView {
    
    var usersTable: UsersTable?
    
    var builder: TournamentBuilder = .init(numberOfLayers: 2)
    
    var entryNames = [Int: String]()
    
    private lazy var tournamentView: KRTournamentView = {
        let tournamentView = KRTournamentView()
        tournamentView.dataSource = self
        tournamentView.delegate = self
        tournamentView.lineColor = .black
        tournamentView.style = KRTournamentViewStyle.left
        tournamentView.lineWidth = 4
        tournamentView.lineColor = UIColor.black
        tournamentView.winnerLineColor = UIColor.orange
        tournamentView.winnerLineWidth = 5
        tournamentView.isMultipleTouchEnabled = true
        tournamentView.translatesAutoresizingMaskIntoConstraints = false
        return tournamentView
    }()
   
    convenience init(usersTable: UsersTable) {
        self.init()
        self.backgroundColor = .backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.usersTable = usersTable
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(tournamentView)
        
        NSLayoutConstraint.activate([
            tournamentView.topAnchor.constraint(equalTo: self.topAnchor),
            tournamentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tournamentView.widthAnchor.constraint(equalTo: self.widthAnchor),
            tournamentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func reloadData() {
        tournamentView.reloadData()
    }
    
}

extension CompetitionNetView: KRTournamentViewDataSource {
    func entrySize(in tournamentView: KRTournamentView) -> CGSize {
        CGSize(width: self.layer.bounds.width/6, height: self.layer.bounds.height/10)
    }

    func structure(of tournamentView: KRTournamentView) -> Bracket {
        builder.build(format: true)
    }

    func tournamentView(_ tournamentView: KRTournamentView, entryAt index: Int) -> KRTournamentViewEntry {
        let entry = KRTournamentViewEntry()

        entry.textLabel.text = "player \(index)"

        entry.textLabel.font = UIFont.anyCompSmallFont

        return entry
    }

    func tournamentView(_ tournamentView: KRTournamentView, matchAt matchPath: MatchPath) -> KRTournamentViewMatch {
        MyMatch()
    }
}

extension CompetitionNetView: KRTournamentViewDelegate {

    func tournamentView(_ tournamentView: KRTournamentView, didSelectEntryAt index: Int) {
        
        print("didSelectEntryAt\(index)")
        
        tournamentView.reloadData()
    }

    func tournamentView(_ tournamentView: KRTournamentView, didSelectMatchAt matchPath: MatchPath) {
        
        tournamentView.reloadData()
        
//        let vc = MatchViewController(matchPath: matchPath) as MatchViewController
//
//        for i in 0...(usersTable?.playersArray.count)!-1 {
//                    if i == matchPath.item*2 {
//
//                    }
//                }
        
        print("didSelectMatchAt\(matchPath)")
        
    }
}
