//
//  CompetitionViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 24.09.2022.
//

import UIKit

class CompetitionViewController: UIViewController {
    
    private let decoder = JSONDecoder()
    
    let database = Database()
    
    static var competition: Competition?
    
    var side = CGFloat(40)
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    var qtyPlayers: Int?
    
    private lazy var tableCollectionView = CompetitionTableView(
        competitionTable: (CompetitionViewController.competition?.competitionTable!)!,
        side: self.view.layer.bounds.width/8,
        playersArray: (CompetitionViewController.competition?.players)!
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.database.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .backgroundColor
        self.side = self.view.layer.bounds.width/8
        setupController()
        if let collectionId = CompetitionViewController.competition?.id {
            database.addListenerToCompetition(collectionId)
        } else {
            print("Something wrong with collectionId")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupController() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tableCollectionView)
        tableCollectionView.delegate = self
  
        let inset: CGFloat = 16
        
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
            tableCollectionView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            tableCollectionView.heightAnchor.constraint(equalToConstant: side*CGFloat(qtyPlayers!+1)),
            tableCollectionView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor),
            tableCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -inset),
        ])

    }

}

extension CompetitionViewController: CompetitionTableViewDelegate {
    func chooseMatch(_ indexPathOfMatch: IndexPath) {
        
        guard let match = CompetitionViewController.competition?.competitionTable?.competitionTable[indexPathOfMatch.section].matchesOfPlayer[indexPathOfMatch.row]  else { return }
        
        let vc = MatchViewController(match: match)
        vc.delegate = self
        self.navigationController?.present(vc, animated: true)
        
    }
    
    
}

extension CompetitionViewController: MatchViewControllerDelegate {
    func winning(_ match: Match) {
        CompetitionViewController.competition?.competitionTable?.finishMatch(match)
        self.tableCollectionView.tableCollectionView.reloadData()
        self.tableCollectionView.playersScoreCollectionView.reloadData()
        database.updateCompetitionDataToDataBase(CompetitionViewController.competition!, CompetitionViewController.competition!.id!)

    }
}

extension CompetitionViewController: DatabaseDelegate {
    func receivedAllUsers(users: [User]) {
        
    }
    
    func sendError() {
        
    }
    
    func reloadViewWithoutAnimate(user: User) {}
    
    func animateAndReloadView(user: User) {}
    
    func alertMessage(alertMessage: String) {
        
    }
    
    func reloadView(user: User) {}
 
    func reloadView(competitions: [Competition]) {}
    
    func reloadTableCollectionView() {
        tableCollectionView.reloadData(competitionTable: CompetitionViewController.competition!.competitionTable!, playersArray: CompetitionViewController.competition!.players)
    }
 
}
