//
//  CompetitionsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import Lottie

class CompetitionsCollectionViewController: UICollectionViewController {
    
    var competitions = [Competition]()
    
    let database = Database()
    
    let animationView = AnimationView()
    
    var isAddedListener = false
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.database.delegate = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .backgroundColor
        self.collectionView.register(CompetitionCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionCollectionViewCell.identifire)
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupListenerToCompetitions()
    }
    
    private func setupAnimation() {
        animationView.animation = Animation.named("loading")
        animationView.frame = CGRect(origin: CGPoint(x: view.bounds.width/4, y: 0), size: CGSize(width: view.bounds.width/2, height: view.bounds.height/6))
        animationView.backgroundColor = .backgroundColor
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        self.collectionView.addSubview(animationView)
    }
    
    private func setupNavigationBar() {
        let plus = UIImage(systemName: "plus")

        self.navigationController?.navigationBar.tintColor = .anyDarckColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: plus, style: .plain, target: self, action: #selector(addCompetition))
    }
    
    private func setupListenerToCompetitions() {
        if (ProfileViewController.user?.id) != nil {
            if !isAddedListener {
                self.database.addListenerToCompetitionCollection()
                isAddedListener.toggle()
            }
        } else {
            self.database.removeListenerToCompetitionCollection()
            alert.message = "Сначала нужно авторизоваться, чтобы увидеть свои соревнования"
            self.present(alert, animated: true)
        }
    }
    
    @objc func addCompetition() {
        let vc = AddCompetitionViewController()
        self.navigationController?.present(vc, animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return competitions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionCollectionViewCell.identifire, for: indexPath) as! CompetitionCollectionViewCell
        
        cell.nameLabel.text = competitions[indexPath.row].title
        cell.dateLabel.text = dateFormater(competitions[indexPath.row].date)
        
        switch indexPath.row % 2 {
        case 0: cell.contentView.backgroundColor = .anyColor
        case 1: cell.contentView.backgroundColor = .anyColor1
        default:
            cell.backgroundColor = .anyColor
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CompetitionViewController()
        
        CompetitionViewController.competition = competitions[indexPath.row]
        
        vc.qtyPlayers = competitions[indexPath.row].players.count
        
        vc.navigationItem.title = CompetitionViewController.competition?.title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension CompetitionsCollectionViewController: DatabaseDelegate {
    func reloadViewWithoutAnimate(user: User) {}
    
    func animateAndReloadView(user: User) {}
    
    func reloadView(user: User) {}
    
    func reloadTableCollectionView() {}
    
    func reloadView(competitions: [Competition]) {
        
        self.competitions = competitions.sorted { $0.date > $1.date }
        self.collectionView.reloadData()
        self.animationView.layer.opacity = 0
        self.animationView.stop()
    }
}




