//
//  Database.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 16.10.2022.
//

import Foundation
import FirebaseFirestore
import RxCocoa
import RxSwift

protocol DatabaseDelegate: AnyObject {
    func reloadViewWithoutAnimate(user: User)
    func animateAndReloadView(user: User)
    func reloadTableCollectionView()
    func alertMessage(alertMessage: String)
    func receivedAllUsers(users: [User])
}

class Database {

    var delegate: DatabaseDelegate?
    
    let userDefaults = UserDefaults.standard
    
    var db = Firestore.firestore()
    
    private let decoder = JSONDecoder()
    
    public var usersDatabase = PublishRelay<[User]>()
    
    public var competitionsDatabase = PublishRelay<[Competition]>()
   
//      отправка созданного соревнования в Firebase Database
    func sendCompetitionToDatabase(competition: Competition) {
        print("--- send competition to Firestore DataBase")
        var ref: DocumentReference? = nil
        
        var tempCompetiton = competition
        
        ref = db.collection("competitions").addDocument(data: [
            "title": tempCompetiton.title,
            "qtyPlayers": tempCompetiton.qtyPlayers,
            "date": tempCompetiton.date,
            "accessUsersIdArray": tempCompetiton.accessUsersIdArray.map{ $0 },
            "players": tempCompetiton.players.map{ $0.dictionary},
            "competitionTable": tempCompetiton.competitionTable!.dictionary
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                tempCompetiton.id = ref!.documentID
                print("--- Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
//      запрос всех документов из коллекции competitions с Firebase Database
    func getAllCompetitions(){
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
//                self.delegate?.reloadView(competitions: competitions)
                competitionsDatabase.accept(competitions)
                
            } else {
                print("error - \(error as Any)")
            }
        }
        
    }
    
//      запрос всех документов из коллекции users с Firebase Database
    func getAllUsers(){
            print("--- get data from Firestore DataBase")
            
            let docRef = db.collection("users")
            
            var usersArray = [User]()
            
            docRef.getDocuments() { [self] snapshotData, error in
                if snapshotData != nil {
                    if snapshotData?.documents.count != 0 {
                        for i in 0...(snapshotData?.documents.count)!-1 {
                            var json = snapshotData?.documents[i].data()
                            json?["docId"] = snapshotData?.documents[i].documentID
                            do {
                                
                                let data = try JSONSerialization.data(withJSONObject: json! as Any)
                                
                                let user = try self.decoder.decode(User.self, from: data)
                                
                                usersArray.append(user)
                                
                            } catch {
                                print("an error occurred", error)
                            }
                        }
                    }
                    usersDatabase.accept(usersArray)
                    
                    delegate?.receivedAllUsers(users: usersArray)
                    
                } else {
                    print("error - \(error as Any)")
                }
            }
            
        }
    
//      запрос данных пользователя Firebase Database
    func getUserData(uid: String, isReloadView: Bool) {
        print("--- get UserData from Firestore DataBase")
        
        let docRef = Firestore.firestore().collection("users")
        
        docRef.getDocuments() { [self] snapshotData, error in
            print("--- receive UserData from dataBase")
            if snapshotData != nil {
                if snapshotData?.documents.count != 0 {
                    for i in 0...(snapshotData?.documents.count)!-1 {
                        var json = snapshotData?.documents[i].data()
                        if json!["id"] as! String == uid {
                            
                            json?["docId"] = snapshotData?.documents[i].documentID
                            
                            do {
                                let data = try JSONSerialization.data(withJSONObject: json! as Any)
                                
                                let tempUser = try self.decoder.decode(User.self, from: data)
                                ProfileViewController.user = tempUser
                                TabBarController.user = tempUser
                                if isReloadView {
                                    delegate?.animateAndReloadView(user: tempUser)
                                } else {
                                    delegate?.reloadViewWithoutAnimate(user: tempUser)
                                }
                                
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
            
            transaction.setData([
                "title": tempCompetiton.title,
                "qtyPlayers": tempCompetiton.qtyPlayers,
                "date": tempCompetiton.date,
                "accessUsersIdArray": tempCompetiton.accessUsersIdArray.map{ $0 },
                "players": tempCompetiton.players.map{ $0.dictionary},
                "competitionTable": tempCompetiton.competitionTable!.dictionary
                ], forDocument: docRef)
            
            return nil
        } completion: { data, error in
            if let error = error {
                    print("Transaction failed: \(error)")
                } else {
                    print("--- Transaction successfully committed!")
                }
        }

    }
    
 //      метод добавляет пользователя в Firebase
     func addUser(user: User) {
         print("--- send user to Firestore DataBase")
         let ref: DocumentReference?
         
         let tempUser = user
         
         ref = db.collection("users").addDocument(data: [
             "id": tempUser.id as Any,
             "firstName": tempUser.firstName,
             "lastName": tempUser.lastName,
             "nick" : tempUser.nick,
             "mail" : tempUser.mail,
             "friends": tempUser.friends.map{ $0.dictionary },
             "playedGames": tempUser.playedGames,
             "wonGames": tempUser.wonGames,
             "lostGames": tempUser.lostGames,
             "wonCups": tempUser.wonCups,
         ]) { err in
             if let err = err {
                 print("--- Error adding document: \(err)")
             }
         }
     }

//MARK: - listeners
//      метод добавляет слушателя для всей коллекции соревнований
    func addListenerToCompetitionCollection(uid: String) {
        print("--- added listener to collection competitions")
        
        var competitions = [Competition]()
        
        let ref = db.collection("competitions").whereField("accessUsersIdArray", arrayContainsAny: [uid])
        
        ref.addSnapshotListener({ querySnapshot, error in
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

                self.competitionsDatabase.accept(competitions)

            }
            
        })
        
    }
    
//      метод удаляет слушателя для всей коллекции соревнований
    func removeListenerToCompetitionCollection() {
        print("--- remove listener to collection competitions")
        
        let competitions = [Competition]()
        
        let ref = db.collection("competitions").whereField("accessUsersIdArray", arrayContainsAny: [ProfileViewController.user?.id]).addSnapshotListener({ querySnapshot, error in
            
        }).remove()
        
        self.competitionsDatabase.accept(competitions)
    }
    
//      метод добавляет слушателя для документа
    func addListenerToCompetition(_ competitionId: String) {
        
        print("--- added listener to competition")
        
        let ref = db.collection("competitions").document(competitionId)

        ref.addSnapshotListener { [self] documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }

            guard var json = document.data() else {
                print("--- Document data was empty.")
                return
            }

            json["id"] = document.documentID

            do {
                let data = try JSONSerialization.data(withJSONObject: json as Any)

                let competition = try self.decoder.decode(Competition.self, from: data)
                CompetitionViewController.competition = competition
                delegate?.reloadTableCollectionView()
            } catch {
                print("an error occurred", error)
            }
        }
    }

}
