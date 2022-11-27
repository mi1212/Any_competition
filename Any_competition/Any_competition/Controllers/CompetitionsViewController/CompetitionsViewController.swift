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
    
    var user: User? {
        didSet {

        }
    }
    
    let competitionsCollectionView = CompetitionsCollectionView()
    
    let loadingAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("loading")
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        super.viewDidLoad()
        setupNavigationBar()
        requestCompetitions()
        addObserverToCompetitionsDatabase()
        requestUserData()
        addObserverToUserDatabase()
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
            make.bottom.equalToSuperview()
        }

    }
    
//     установка анимации загрузки
    private func setupLoading() {
        self.view.addSubview(loadingAnimationView)
        loadingAnimationView.layer.opacity = 1
        loadingAnimationView.play()
        NSLayoutConstraint.activate([
            loadingAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingAnimationView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    @objc func addCompetition() {
        
        if user != nil {
            let vc = AddCompetitionViewController()
            vc.user = user
            self.navigationController?.present(vc, animated: true)
        }
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
        setupLoading()
        database.competitionsDatabase.subscribe { [self] competitions in
//            setupLoading()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                let tempComp = competitions
                self.competitions = tempComp.sorted { $0.date > $1.date }
                loadingAnimationView.removeFromSuperview()
//            }
            
        }
    }
    
    // MARK: - user data
    
    private func requestUserData() {
        if let uid = userDefaults.object(forKey: "uid") {
            database.getUserData(uid: uid as! String)
        }
    }
    
    func addObserverToUserDatabase() {
        database.userDatabase.subscribe { [self] userData in
            self.user = userData
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




