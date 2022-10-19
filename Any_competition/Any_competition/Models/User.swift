//
//  User.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 19.10.2022.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: String?
    var firstName: String
    var lastName: String
    var nick: String
    var mail: String
    
    var dictionary: [String: Any] {
        return [
            "firstname": firstName,
            "lastName": lastName,
            "nick": nick,
            "mail": mail
        ]
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.nick == rhs.nick
    }
    
  }
