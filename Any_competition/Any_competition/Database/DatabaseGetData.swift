//
//  DatabaseGetData.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 24.09.2022.
//

import Foundation
import FirebaseFirestore

class DatabaseGetData {
    
    var db = Firestore.firestore()
    
    private let decoder = JSONDecoder()

    var datarequest: Competition!
    
    init() {}
    
    func getData() {
        
        let docRef = db.collection("competitions")

        
        docRef.getDocuments() { snapshotData, error in
            
            if snapshotData != nil {

                let json = snapshotData?.documents[0].data()

                do {

                    let data = try JSONSerialization.data(withJSONObject: json! as Any)

                    self.datarequest = try self.decoder.decode(Competition.self, from: data)

                } catch {

                    print("an error occurred", error)
                }

            } else {

                print("error - \(error as Any)")
            }

        }
        


    }
    
}
