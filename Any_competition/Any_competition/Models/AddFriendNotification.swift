//
//  AddFriendNotification.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 17.11.2022.
//

import Foundation

struct AddFriendNotification: Codable, Hashable {
    
    let date: String
    let userFriend: User // User, который просится в друзья
    
    var dictionary: [String: Any] {
        return [
            
            "userFriend": userFriend.dictionary,
            "date": date,
            
        ]
    }
    func confirmAdd () {
        
    }
    
    func declineAdd () {
        
    }
    
    public static func == (lhs: AddFriendNotification, rhs: AddFriendNotification) -> Bool {
//        lhs.date == rhs.date && lhs.userFriend == rhs.userFriend
        lhs.userFriend == rhs.userFriend
    }
    
}
