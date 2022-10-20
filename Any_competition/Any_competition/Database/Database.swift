//
//  Database.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 16.10.2022.
//

import Foundation
import FirebaseFirestore

protocol DatabaseDelegate: AnyObject {
    func reloadView(competitions: [Competition])
    func reloadView(user: User)
    func reloadTableCollectionView()
}

class Database {

    var delegate: DatabaseDelegate?
    
    var db = Firestore.firestore()
    
    private let decoder = JSONDecoder()
   
// отправка созданного соревнования в Firebase Database
    func sendCompetitionToDatabase(competition: Competition) {
        print("--- send competition to Firestore DataBase")
        var ref: DocumentReference? = nil
        
        var tempCompetiton = competition
        
        ref = db.collection("competitions").addDocument(data: [
            "info": tempCompetiton.info.dictionary,
            "players": tempCompetiton.players.map{ $0.dictionary },
            "competitionTable": tempCompetiton.competitionTable!.dictionary
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                tempCompetiton.id = ref!.documentID
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
//      запрос всех документов с Firebase Database
    func getAllDocuments(){
        print("--- get data from Firestore DataBase")
        
        let docRef = db.collection("competitions")
        
        var competitions = [Competition]()
        
        docRef.getDocuments() { [self] snapshotData, error in
            if snapshotData != nil {
                if snapshotData?.documents.count != 0 {
                    for i in 0...(snapshotData?.documents.count)!-1 {
                        var json = snapshotData?.documents[i].data()
                        json?["id"] = snapshotData?.documents[i].documentID
                        do {
                            let data = try JSONSerialization.data(withJSONObject: json! as Any)
                            
                            let competition = try self.decoder.decode(Competition.self, from: data)
                            
                            competitions.append(competition)
                        } catch {
                            print("an error occurred", error)
                        }
                    }
                }
                self.delegate?.reloadView(competitions: competitions)

                
            } else {
                print("error - \(error as Any)")
            }
        }
        
    }
    
    func getUserData(uid: String) {
        print("--- get user data from Firestore DataBase")
        
        let docRef = Firestore.firestore().collection("users")
        
        docRef.getDocuments() { [self] snapshotData, error in
            print("--- receive data from dataBase")
            if snapshotData != nil {
                if snapshotData?.documents.count != 0 {
                    for i in 0...(snapshotData?.documents.count)!-1 {
                        var json = snapshotData?.documents[i].data()
                        if json!["id"] as! String == uid {
                            
                            json?["docId"] = snapshotData?.documents[i].documentID
                            
                            do {
                                let data = try JSONSerialization.data(withJSONObject: json! as Any)
                                
                                let tempUser = try self.decoder.decode(User.self, from: data)
                                delegate?.reloadView(user: tempUser)
                            } catch {
                                print("an error occurred", error)
                            }
                            
                            
                        }
                        
                    }
                }
                
            } else {
                print("error - \(error as Any)")
            }
        }
        
    }
    
//      метод отправки обновленных данных в соревновании, если произошли события
    func updateCompetitionDataToDataBase(_ competition: Competition ,_ competitionId: String) {
        print("--- send competition data to Firestore DataBase")
        
        let docRef = db.collection("competitions").document(competitionId)
        
        let tempCompetiton = competition
        
        db.runTransaction { (transaction, errorPointer) -> Any? in
            
            let sfDocument: DocumentSnapshot

                do {
                    try sfDocument = transaction.getDocument(docRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
            
            transaction.setData([
                    "info": tempCompetiton.info.dictionary,
                    "players": tempCompetiton.players.map{ $0.dictionary },
                    "competitionTable": tempCompetiton.competitionTable!.dictionary
                ], forDocument: docRef)
            
            return nil
        } completion: { data, error in
            if let error = error {
                    print("Transaction failed: \(error)")
                } else {
                    print("Transaction successfully committed!")
                }
        }

    }
    
//      метод добавляет слушателя для документа
    func addListener(_ competitionId: String) {
        
        print("--- added listener to competition")
        
        db.collection("competitions").document(competitionId).addSnapshotListener { [self] documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }

            guard var json = document.data() else {
                print("Document data was empty.")
                return
            }

            json["id"] = document.documentID
            
            do {
                let data = try JSONSerialization.data(withJSONObject: json as Any)
                
                let competition = try self.decoder.decode(Competition.self, from: data)
                CompetitionViewController.competition = competition
                delegate?.reloadTableCollectionView()
//                self.tableCollectionView.reloadData(competitionTable: competition.competitionTable!)
            } catch {
                print("an error occurred", error)
            }
        }

    }
    
//      метод добавляет слушателя для всей коллекции соревнований
    func addListenerToCollection() {
        print("--- added listener to collection competitions")
        
        var competitions = [Competition]()
        
        db.collection("competitions").addSnapshotListener({ querySnapshot, error in
            guard let snapshotData = querySnapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            if snapshotData.count != 0 {
                
                competitions.removeAll()
                
                for i in 0...snapshotData.count-1 {
                    var json = snapshotData[i].data()
                    json["id"] = snapshotData[i].documentID
                    do {
                        let data = try JSONSerialization.data(withJSONObject: json as Any)
                        
                        let competition = try self.decoder.decode(Competition.self, from: data)
                        
                        competitions.append(competition)
                    } catch {
                        print("an error occurred", error)
                    }
                }
            }
            self.delegate?.reloadView(competitions: competitions)
            
        })
            
        
    }
//      метод добавляет пользователя
    func addUser(user: User) {
        print("--- send user to Firestore DataBase")
        var ref: DocumentReference? = nil
        
        let tempUser = user
        
        ref = db.collection("users").addDocument(data: [
            "id": tempUser.id as Any,
            "firstName": tempUser.firstName,
            "lastName": tempUser.lastName,
            "nick" : tempUser.nick,
            "mail" : tempUser.mail
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
    }
    
    
}
