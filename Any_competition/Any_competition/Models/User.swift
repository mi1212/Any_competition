//
//  User.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 19.10.2022.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable, Hashable {
    
    var firstName: String
    var lastName: String
    var nick: String
    var docId: String?
    var id: String?
    var mail: String = ""
    var friends: [String]?
    var playedGames: Int = 0
    var wonGames: Int = 0
    var lostGames: Int = 0
    var wonCups: Int = 0
    var notificationArray: [AddFriendNotification] = []
     
    var dictionary: [String: Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "nick": nick,
            "id": id,
            "mail": mail,
            "friends": friends.map{ $0 },
            "playedGames": playedGames,
            "wonGames": wonGames,
            "lostGames": lostGames,
            "wonCups": wonCups,
            "notificationArray": notificationArray.map {$0.dictionary}
        ]
    }
    
    init(firstName: String, lastName: String, nick: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.nick = nick
    }
    
    public static func == (lhs: User, rhs: User) -> Bool {
        lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.nick == rhs.nick && lhs.notificationArray == rhs.notificationArray
    }
    
}

//struct Wrapped: Decodable {
//    let docRef: DocumentReference
//
//    public init(from decoder: Decoder) throws {
////        let container = try decoder....
//
//    }
//}
