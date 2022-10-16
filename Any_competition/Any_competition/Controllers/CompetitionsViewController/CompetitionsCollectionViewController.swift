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
    
    var competitions = [Competition]()
        
    let animationView = AnimationView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
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
        
        self.collectionView.reloadData()
        
    }
    // запрос данных с Firebase Database
    func getData() {
        print("--- getData from Firestore DataBase")
        self.setupAnimation()
        
        let docRef = db.collection("competitions")
        
        docRef.getDocuments() { snapshotData, error in
            if snapshotData != nil {
                
                self.competitions.removeAll()
                
                for i in 0...(snapshotData?.documents.count)!-1 {
                    var json = snapshotData?.documents[i].data()
                    json?["id"] = snapshotData?.documents[i].documentID
                    do {
                        let data = try JSONSerialization.data(withJSONObject: json! as Any)
                        
                        let competition = try self.decoder.decode(Competition.self, from: data)
                        self.competitions.append(competition)
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
//      метод, который добавляет слушателя для документа,
//      чтобы отслеживать внешнние изменения в нем на сервере
//      private func addListener(_ competitionId: String) {
//
//        db.collection("competitions").document(competitionId).addSnapshotListener { documentSnapshot, error in
//            guard let document = documentSnapshot else {
//              print("Error fetching document: \(error!)")
//              return
//            }
//            guard var json = document.data() else {
//              print("Document data was empty.")
//              return
//            }
//
//            json["id"] = document.documentID
//            do {
//
//                self.competitions.removeAll()
//
//                let data = try JSONSerialization.data(withJSONObject: json as Any)
//
//                let competition = try self.decoder.decode(Competition.self, from: data)
//                self.competitions.append(competition)
//            } catch {
//                print("an error occurred", error)
//            }
//            self.collectionView.reloadData()
//
//          }
//
//    }
    
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
        CompetitionViewController.competitionTable = CompetitionTable(playersArray: competitions[indexPath.row].players)
        
        vc.navigationItem.title = CompetitionViewController.competition?.info.title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}




