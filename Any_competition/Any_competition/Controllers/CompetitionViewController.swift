//
//  CompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 24.09.2022.
//

import UIKit
import KRTournamentView

class CompetitionViewController: UIViewController{
   
    static var competitionCell: Competition?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.backgroundColor = .white
        return content
    }()
    
    let titleLabel = AnyCompUILabel(title: "Title: ")

    let qtyPlayersLabel = AnyCompUILabel(title: "qtyPlayers: ")

    let typeSportLabel = AnyCompUILabel(title: "typeSport: ")

    let dateLabel = AnyCompUILabel(title: "date: ")
    
    private lazy var tournamentView: KRTournamentView = {
        let tournamentView = KRTournamentView()
        tournamentView.backgroundColor = .white
        tournamentView.dataSource = self
        tournamentView.delegate = self
        tournamentView.lineColor = .black
        tournamentView.style = KRTournamentViewStyle.left
        tournamentView.lineWidth = 4
        tournamentView.lineColor = UIColor.darkGray
        tournamentView.winnerLineColor = UIColor.orange
        tournamentView.winnerLineWidth = 5
        tournamentView.isMultipleTouchEnabled = true
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
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(qtyPlayersLabel)
        contentView.addSubview(typeSportLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tournamentView)
        
        let inset: CGFloat = 12
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: inset)
        ])

        NSLayoutConstraint.activate([
            qtyPlayersLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            qtyPlayersLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: inset/2),
            qtyPlayersLabel.heightAnchor.constraint(equalToConstant: inset)
        ])

        NSLayoutConstraint.activate([
            typeSportLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            typeSportLabel.topAnchor.constraint(equalTo: self.qtyPlayersLabel.bottomAnchor, constant: inset/2),
            typeSportLabel.heightAnchor.constraint(equalToConstant: inset)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            dateLabel.topAnchor.constraint(equalTo: self.typeSportLabel.bottomAnchor, constant: inset/2),
            dateLabel.heightAnchor.constraint(equalToConstant: inset)
        ])
        
        NSLayoutConstraint.activate([
            tournamentView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: inset/2),
            tournamentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            tournamentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset),
            tournamentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -inset),
            tournamentView.heightAnchor.constraint(equalToConstant: inset*CGFloat((CompetitionViewController.competitionCell?.players.count)!*4))
        ])
    }
    
    private func setupLabel() {
        titleLabel.text! = (CompetitionViewController.competitionCell?.info.title)!
        qtyPlayersLabel.text! += "\((CompetitionViewController.competitionCell?.info.qtyPlayers)!)"
        typeSportLabel.text! = (CompetitionViewController.competitionCell?.info.sportType)!

        if let stringDate = (CompetitionViewController.competitionCell?.info.date) {
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
        CGSize(width: self.view.layer.bounds.width/6, height: self.view.layer.bounds.height/10)
    }

    func structure(of tournamentView: KRTournamentView) -> Bracket {
        builder.build(format: true)
    }

    func tournamentView(_ tournamentView: KRTournamentView, entryAt index: Int) -> KRTournamentViewEntry {
        let entry = KRTournamentViewEntry()

        entry.textLabel.text = (CompetitionViewController.competitionCell!.players[index].name) + " " + (CompetitionViewController.competitionCell!.players[index].secondName)

//        entry.textLabel.text = "player \(index)"

        let font = UIFont(name: "Press Start 2P", size: 8)

        entry.textLabel.font = font

        return entry
    }

    func tournamentView(_ tournamentView: KRTournamentView, matchAt matchPath: MatchPath) -> KRTournamentViewMatch {
        MyMatch()
    }
}

extension CompetitionViewController: KRTournamentViewDelegate {

    func tournamentView(_ tournamentView: KRTournamentView, didSelectEntryAt index: Int) {

        tournamentView.reloadData()
    }

    func tournamentView(_ tournamentView: KRTournamentView, didSelectMatchAt matchPath: MatchPath) {
        let players = builder.getChildBuilder(for: matchPath)?.children
        tournamentView.reloadData()
        let vc = MatchViewController(matchPath: matchPath) as MatchViewController
        vc.delegate = self
//        for i in 0...(competitionCell?.players.count)!-1 {
//            if i == matchPath.item*2 {
//                vc.firstPlayerLabel.text = (competitionCell?.players[i].name)! + " " + (competitionCell?.players[i].secondName)!
//                vc.secondPlayerLabel.text = (competitionCell?.players[i+1].name)! + " " + (competitionCell?.players[i+1].secondName)!
//            }
//        }



        self.present(vc, animated: true)
        print("didSelectMatchAt\(matchPath)")
    }
}

extension CompetitionViewController: MatchViewControllerDelegate {
    func firstPlayerWin(matchPath: MatchPath) {
        builder.getChildBuilder(for: matchPath)?.setWinnerIndexes([0])
        print("firstPlayerWin")
        self.tournamentView.reloadData()
    }

    func secondPlayerWin(matchPath: MatchPath) {
        builder.getChildBuilder(for: matchPath)?.setWinnerIndexes([1])
        print("secondPlayerWin")
        self.tournamentView.reloadData()
    }
}
