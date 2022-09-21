//
//  CompetitionFetch.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation
import FirebaseDatabase

class CompetitionFetch {
    
    var database: Database?

    var databasePath: DatabaseReference? = {
      
        let ref = Database.database().reference().child("competition/")
        
    //    let autoId = DatabaseReference.childByAutoId(ref)
    //
    //    let refComp = autoId()

      return ref
    }()

    public func getData() {
        
        databasePath?.getData(completion: { error, data in
            print(data)
        })
        
    }
}


