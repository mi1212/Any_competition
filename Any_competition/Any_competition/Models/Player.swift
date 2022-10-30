//
//  Player.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 10.10.2022.
//

import Foundation

class Player: Codable {
    var firstName: String
    var lastName: String
    var nick: String
    
    var dictionary: [String: Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "nick": nick
        ]
    }

    init(firstName: String, lastName: String, nick: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.nick = nick
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case nick
    }
    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        var list = try container.nestedUnkeyedContainer(forKey: Player.CodingKeys.firstName)
//        
//        if let player = try? list.decode(Player.self) {
//            player
//        }
//    }
}
    
//    public static func == (lhs: Player, rhs: Player) -> Bool {
//        lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.nick == rhs.nick
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(firstName)
//        hasher.combine(lastName)
//        hasher.combine(nick)
//    }
 

