//
//  CompetitionModel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation

struct Competition: Identifiable, Codable {
    var id: String?
    let title: String
    let qtyPlayers: Int
    let date: String
    let accessUsersIdArray: [String]
    let players: [Player]
    var competitionTable: CompetitionTable?
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "qtyPlayers": qtyPlayers,
            "date": date,
            "accessUsersIdArray": accessUsersIdArray.map{ $0 },
            "players": players.map{ $0.dictionary },
            "competitionTable": competitionTable!.dictionary
        ]
    }
    
    init(title: String, qtyPlayers: Int, date: String, players: [Player], accessUserArray: [User]) {
        self.title = title
        self.qtyPlayers = qtyPlayers
        self.date = date
        self.players = players
        self.competitionTable = CompetitionTable(playersArray: self.players)
//        var accessUserArray = [User]()
//        accessUserArray.append(accessUser)
        self.accessUsersIdArray = accessUserArray.map {$0.id!}
    }
    
}
