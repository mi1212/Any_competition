//
//  User.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 19.10.2022.
//

import Foundation

class User: Player {
    var docId: String?
    var id: String?
    var mail: String = ""
    var playedGames: Int = 0
    var wonGames: Int = 0
    var lostGames: Int = 0
    var wonCups: Int = 0
    
    init(firstName: String, lastName: String, nick: String, mail: String){
        super.init(firstName: firstName, lastName: lastName, nick: nick)
        self.mail = mail
    }
    
    private enum CodingKeys: String, CodingKey {
        case docId
        case id
        case mail
        case playedGames
        case wonGames
        case lostGames
        case wonCups
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.docId = try container.decode(String.self, forKey: .docId)
        self.id = try container.decode(String.self, forKey: .id)
        self.mail = try container.decode(String.self, forKey: .mail)
        self.playedGames = try container.decode(Int.self, forKey: .playedGames)
        self.wonGames = try container.decode(Int.self, forKey: .wonGames)
        self.lostGames = try container.decode(Int.self, forKey: .lostGames)
        self.wonCups = try container.decode(Int.self, forKey: .wonCups)
        try super.init(from: decoder)
    }
    
}
