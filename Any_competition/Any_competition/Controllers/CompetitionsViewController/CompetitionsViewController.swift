//
//  CompetitionsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import Lottie

class CompetitionsViewController: UIViewController {
    
    static var competitions = [Competition]()
    
    let database = Database()
    
    let userDefaults = UserDefaults.standard
    
    let animationView = AnimationView()
    
    var isAddedListener = false
    
    var timer: Timer?
    
    let competitionsCollectionView = CompetitionsCollectionView()
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        self.database.delegate = self
        setupNavigationBar()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupListenerToCompetitions()
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("loading")
        animationView.frame = CGRect(origin: CGPoint(x: view.bounds.width/4, y: 0), size: CGSize(width: view.bounds.width/2, height: view.bounds.height/6))
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        self.view.addSubview(animationView)
    }
    
    private func setupNavigationBar() {
        let plus = UIImage(systemName: "plus")
        
        self.navigationController?.navigationBar.tintColor = .anyDarckColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plus, style: .plain, target: self, action: #selector(addCompetition))
    }
    
    private func setupViews() {
        self.view.addSubview(competitionsCollectionView)
        self.competitionsCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            competitionsCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            competitionsCollectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            competitionsCollectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            competitionsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupListenerToCompetitions() {
        if let uid = userDefaults.object(forKey: "uid") {
            if !isAddedListener {
                self.database.addListenerToCompetitionCollection(uid: uid as! String)
//                isAddedListener.toggle()
            }
        } else {
            CompetitionsViewController.competitions = [Competition]()
            competitionsCollectionView.competitionsCollectionView.reloadData()
            alert.message = "Сначала нужно авторизоваться, чтобы увидеть свои соревнования"
            self.present(alert, animated: true)
        }
    }
    
    @objc func addCompetition() {
        let vc = AddCompetitionViewController()
        self.navigationController?.present(vc, animated: true)
    }
    
}

extension CompetitionsViewController: DatabaseDelegate {
    
    func reloadViewWithoutAnimate(user: User) {}
    
    func animateAndReloadView(user: User) {}
    
    func reloadView(user: User) {}
    
    func reloadTableCollectionView() {}
    
    func reloadView(competitions: [Competition]) {
            print("--- competitionsCollectionView.reloadData()")
            CompetitionsViewController.competitions = competitions.sorted { $0.date > $1.date }
            self.competitionsCollectionView.competitionsCollectionView.reloadData()

    }
    
}

extension CompetitionsViewController: CompetitionsCollectionViewDelegate {
    
    func pressCompetition(index: Int) {
        let vc = CompetitionViewController()
        
        CompetitionViewController.competition = CompetitionsViewController.competitions[index]
        
        vc.qtyPlayers = CompetitionsViewController.competitions[index].players.count
        
        vc.navigationItem.title = CompetitionViewController.competition?.title
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}




