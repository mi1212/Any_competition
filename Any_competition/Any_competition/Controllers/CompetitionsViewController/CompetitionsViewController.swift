//
//  CompetitionsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import Lottie

class CompetitionsViewController: UIViewController {
    
    var competitions = [Competition]() {
        didSet{
            competitionsCollectionView.competitions = competitions
        }
    }
    
    let database = Database()
    
    let userDefaults = UserDefaults.standard
    
    let animationView = AnimationView()
    
    static var isAddedListener = false
    
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
        addObserverToCompetitionsDatabase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupListenerToCompetitions()
    }
    
    let loadingAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("loading")
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
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
            
            if !CompetitionsViewController.isAddedListener {
                setupLoading()
                self.database.addListenerToCompetitionCollection(uid: uid as! String)
                CompetitionsViewController.isAddedListener = true
            }
        } else {
            competitions = [Competition]()
            competitionsCollectionView.competitionsCollectionView.reloadData()
            alert.message = "Сначала нужно авторизоваться, чтобы увидеть свои соревнования"
            self.present(alert, animated: true)
        }
    }
    
    // установка анимации загрузки
    private func setupLoading() {
        self.view.addSubview(loadingAnimationView)
        loadingAnimationView.layer.opacity = 1
        loadingAnimationView.play()
        NSLayoutConstraint.activate([
            loadingAnimationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingAnimationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingAnimationView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func addCompetition() {
        let vc = AddCompetitionViewController()
        self.navigationController?.present(vc, animated: true)
    }
    
    func addObserverToCompetitionsDatabase() {
        database.competitionsDatabase.subscribe { [self] competitionsArray in
            loadingAnimationView.removeFromSuperview()
            competitions = competitionsArray.element!
            reloadCollection()
        }
    }
    
    func reloadCollection() {
        self.competitionsCollectionView.reloadCollection()
    }
    
}

extension CompetitionsViewController: DatabaseDelegate {
    func receivedAllUsers(users: [User]) {
        
    }
    
    func alertMessage(alertMessage: String) {
        loadingAnimationView.removeFromSuperview()
    }
    
    func reloadViewWithoutAnimate(user: User) {}
    
    func animateAndReloadView(user: User) {}
    
    func reloadView(user: User) {}
    
    func reloadTableCollectionView() {}
    
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




