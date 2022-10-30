//
//  User.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 19.10.2022.
//

import Foundation

//struct User: Identifiable, Codable, Hashable {
//    var docId: String?
//    var id: String?
//    var firstName: String
//    var lastName: String
//    var nick: String
//    var mail: String
//
//    var dictionary: [String: Any] {
//        return [
//            "firstName": firstName,
//            "lastName": lastName,
//            "nick": nick,
//            "mail": mail,
//            "id": id as Any
//        ]
//    }
//
//    static func == (lhs: User, rhs: User) -> Bool {
//        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.nick == rhs.nick
//    }
//
//  }


class User: Player {
    var docId: String?
    var id: String?
    var mail: String = ""
    
    init(firstName: String, lastName: String, nick: String, mail: String){
        super.init(firstName: firstName, lastName: lastName, nick: nick)
        self.mail = mail
    }
    
    private enum CodingKeys: String, CodingKey {
        case docId
        case id
        case mail
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.docId = try container.decode(String.self, forKey: .docId)
        self.id = try container.decode(String.self, forKey: .id)
        self.mail = try container.decode(String.self, forKey: .mail)
        try super.init(from: decoder)
    }
    
}
