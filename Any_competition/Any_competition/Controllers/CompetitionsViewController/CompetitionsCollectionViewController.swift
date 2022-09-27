//
//  CompetitionsViewController.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import UIKit
import FirebaseFirestore

class CompetitionsCollectionViewController: UICollectionViewController {
    
    var db = Firestore.firestore()
    
    private let decoder = JSONDecoder()

    var datarequest = [Competition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView.register(CompetitionCollectionViewCell.self, forCellWithReuseIdentifier: CompetitionCollectionViewCell.identifire)
        getData()
        self.collectionView.reloadData()
    }
    
    func getData() {
        
        let docRef = db.collection("competitions")

        docRef.getDocuments() { snapshotData, error in
            
            if snapshotData != nil {

                for i in 0...(snapshotData?.documents.count)!-1 {
                    
                    let json = snapshotData?.documents[i].data()
                    
                    do {
                        
                        let data = try JSONSerialization.data(withJSONObject: json! as Any)
                        //
                        let competition = try self.decoder.decode(Competition.self, from: data)
                        
//                        if let timestamp = competition["date"] as? Timestamp {
//                            let date = timestamp.dateValue()
//                            dateFormatter.dateStyle = .medium
//                            dateFormatter.timeStyle = .none
//                            strDate = "\(dateFormatter.string(from: date))"
//                        }
                        
                        self.datarequest.append(competition)
                        
                    } catch {
                        
                        print("an error occurred", error)
                    }
                    
                }
                
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
        cell.label.text = datarequest[indexPath.row].info.title
        cell.label.font = .anyCompMediumFont
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
