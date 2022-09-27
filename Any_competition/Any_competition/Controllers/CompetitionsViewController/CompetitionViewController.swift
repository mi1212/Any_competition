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
    
    var usersTable: UsersTable?
    
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
    
    var qtyPlayers: Int?
    
    private lazy var tableCollectionView = CompetitionTableView(usersTable: self.usersTable!)
    
    private lazy var tournamentView: KRTournamentView = {
        let tournamentView = KRTournamentView()
        tournamentView.backgroundColor = .white
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
    
    private var builder: TournamentBuilder = .init(numberOfLayers: 2)
    
    private var entryNames = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupController()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
        

    }
    
    private func setupController() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tableCollectionView)
        contentView.addSubview(tournamentView)
        
        let inset: CGFloat = 12
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
            
        NSLayoutConstraint.activate([
            tableCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: inset/2),
            tableCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            tableCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            tableCollectionView.heightAnchor.constraint(equalToConstant: self.view.layer.bounds.width*2/3)
        ])
        
        NSLayoutConstraint.activate([
            tournamentView.topAnchor.constraint(equalTo: self.tableCollectionView.bottomAnchor, constant: inset/2),
            tournamentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            tournamentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset),
            tournamentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -inset),
            tournamentView.heightAnchor.constraint(equalToConstant: self.view.layer.bounds.width*2/3)
        ])
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
        
        //        entry.textLabel.text = (CompetitionViewController.competitionCell!.players[index].name) + " " + (CompetitionViewController.competitionCell!.players[index].secondName)
        
        entry.textLabel.text = "player \(index)"
        
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
