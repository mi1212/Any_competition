//
//  Player.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 10.10.2022.
//

import Foundation

struct Player: Codable, Hashable {
    var number: Int
    var name: String
    var secondName: String
    var nick: String?
    
    var dictionary: [String: Any] {
        return["number": number,
            "name": name,
               "secondName": secondName,
               "nick": nick as Any]
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.number == rhs.number && lhs.name == rhs.name && lhs.secondName == rhs.secondName && lhs.nick == rhs.nick
    }
}
