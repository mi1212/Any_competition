//
//  CompetitionsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import Lottie
import SnapKit
import RxCocoa
import RxSwift

class CompetitionsViewController: UIViewController {
    
    let database = Database()
    
    let userDefaults = UserDefaults.standard
    
    var competitions = [Competition]() {
        didSet{
            competitionsCollectionView.competitions = competitions
        }
    }
    
    let competitionsCollectionView = CompetitionsCollectionView()
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        setupNavigationBar()
        requestCompetitions()
        addObserverToCompetitionsDatabase()
        setupCollection()
    }
    
    private func setupNavigationBar() {
        let plus = UIImage(systemName: "plus")
        self.navigationController?.navigationBar.tintColor = .anyDarckColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plus, style: .plain, target: self, action: #selector(addCompetition))
    }
    
    private func setupCollection() {
        view.addSubview(competitionsCollectionView)
        self.competitionsCollectionView.delegate = self
        
        competitionsCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }

    }
    
//    private func setupListenerToCompetitions() {
//        if let uid = userDefaults.object(forKey: "uid") {
//
//            if !CompetitionsViewController.isAddedListener {
//                setupLoading()
//                self.database.addListenerToCompetitionCollection(uid: uid as! String)
//                CompetitionsViewController.isAddedListener = true
//            }
//        } else {
//            competitions = [Competition]()
//            competitionsCollectionView.competitionsCollectionView.reloadData()
//            alert.message = "Сначала нужно авторизоваться, чтобы увидеть свои соревнования"
//            self.present(alert, animated: true)
//        }
//    }
    
    // установка анимации загрузки
//    private func setupLoading() {
//        self.view.addSubview(loadingAnimationView)
//        loadingAnimationView.layer.opacity = 1
//        loadingAnimationView.play()
//        NSLayoutConstraint.activate([
//            loadingAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            loadingAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            loadingAnimationView.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
    
    @objc func addCompetition() {
            let vc = AddCompetitionViewController()
            self.navigationController?.present(vc, animated: true)
    }
    
    func reloadCollection() {
        self.competitionsCollectionView.reloadCollection()
    }
    
    private func requestCompetitions() {
        if let uid = userDefaults.object(forKey: "uid") {
            database.addListenerToCompetitionCollection(uid: uid as! String)
        }
    }
    
    func addObserverToCompetitionsDatabase() {
        database.competitionsDatabase.subscribe { competitions in
            let tempComp = competitions
            self.competitions = tempComp.sorted { $0.date > $1.date }
        }
    }
    
}

extension CompetitionsViewController: CompetitionsCollectionViewDelegate {
    
    func pressCompetition(index: Int) {
        let vc = CompetitionViewController()
        
        CompetitionViewController.competition = competitions[index]
        
        vc.qtyPlayers = competitions[index].players.count
        
        vc.navigationItem.title = CompetitionViewController.competition?.title
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}




