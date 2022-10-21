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
    
    let alert : UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
        return alert
    }()
    
    var isListenerConnected = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.database.delegate = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .backgroundColor
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView.register(CompetitionCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionCollectionViewCell.identifire)
//        self.database.addListenerToCollection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isListenerConnected {
            self.database.addListenerToCollection()
            isListenerConnected.toggle()
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimation()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return competitions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionCollectionViewCell.identifire, for: indexPath) as! CompetitionCollectionViewCell
        
        cell.nameLabel.text = competitions[indexPath.row].info.title
        cell.dateLabel.text = dateFormater(competitions[indexPath.row].info.date)
        
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
        
        vc.navigationItem.title = CompetitionViewController.competition?.info.title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension CompetitionsCollectionViewController: DatabaseDelegate {
    func alertMessage(alertMessage: String) {
        isListenerConnected = true
        
        alert.message = alertMessage
        self.present(alert, animated: true)
    }
    
    func reloadView(user: User) {}
    
    func reloadTableCollectionView() {}
    
    func reloadView(competitions: [Competition]) {
        self.competitions = competitions
        self.collectionView.reloadData()
        self.animationView.layer.opacity = 0
        self.animationView.stop()
    }
}




