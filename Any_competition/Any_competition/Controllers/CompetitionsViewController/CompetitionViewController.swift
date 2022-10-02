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
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    var qtyPlayers: Int?
    
    private lazy var tableCollectionView = CompetitionTableView(usersTable: self.usersTable!)
    
    private lazy var tournamentView = CompetitionNetView(usersTable: self.usersTable!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
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
            tableCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            tableCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset),
            tableCollectionView.heightAnchor.constraint(equalToConstant: self.view.layer.bounds.width*2/3)
        ])
        
        NSLayoutConstraint.activate([
            tournamentView.topAnchor.constraint(equalTo: self.tableCollectionView.bottomAnchor, constant: inset),
            tournamentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
            tournamentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset),
            tournamentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -inset),
            tournamentView.heightAnchor.constraint(equalToConstant: self.view.layer.bounds.width*2/3)
        ])
    }
}



extension CompetitionViewController: MatchViewControllerDelegate {
    
    func firstPlayerWin(matchPath: MatchPath) {
        tournamentView.builder.getChildBuilder(for: matchPath)?.setWinnerIndexes([0])
        print("firstPlayerWin")
        tournamentView.reloadData()
    }
    
    func secondPlayerWin(matchPath: MatchPath) {
        tournamentView.builder.getChildBuilder(for: matchPath)?.setWinnerIndexes([1])
        print("secondPlayerWin")
        tournamentView.reloadData()
    }
    
}
