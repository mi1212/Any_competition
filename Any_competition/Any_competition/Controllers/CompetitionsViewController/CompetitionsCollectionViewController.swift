//
//  CompetitionsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import FirebaseFirestore
import Lottie

class CompetitionsCollectionViewController: UICollectionViewController {
    
    var db = Firestore.firestore()
    
    private let decoder = JSONDecoder()
    
    var datarequest = [Competition]()
    
    var timer: Timer?
    
    let animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .backgroundColor
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView.register(CompetitionCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionCollectionViewCell.identifire)
        getData()
        
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
        getData()
        self.collectionView.reloadData()
        
    }
    
    func getData() {
        
        self.setupAnimation()
        
        let docRef = db.collection("competitions")
        
        docRef.getDocuments() { snapshotData, error in
  
            if snapshotData != nil {
                
                self.datarequest.removeAll()
                
                for i in 0...(snapshotData?.documents.count)!-1 {
                    let json = snapshotData?.documents[i].data()
                    do {
                        let data = try JSONSerialization.data(withJSONObject: json! as Any)
                        let competition = try self.decoder.decode(Competition.self, from: data)
                        self.datarequest.append(competition)
                    } catch {
                        print("an error occurred", error)
                    }
                }
                
                self.animationView.layer.opacity = 0
                self.animationView.stop()
                self.collectionView.reloadData()

            } else {
                print("error - \(error as Any)")
            }
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datarequest.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompetitionCollectionViewCell.identifire, for: indexPath) as! CompetitionCollectionViewCell
        
        cell.nameLabel.text = datarequest[indexPath.row].info.title
        cell.dateLabel.text = dateFormater(datarequest[indexPath.row].info.date)
        
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
        
        CompetitionViewController.competitionCell = datarequest[indexPath.row]
        vc.qtyPlayers = datarequest[indexPath.row].players.count
        vc.usersTable = UsersTable(playersArray: datarequest[indexPath.row].players)
        vc.navigationItem.title = CompetitionViewController.competitionCell?.info.title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
