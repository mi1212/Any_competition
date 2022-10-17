//
//  CompetitionModel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation

struct Competition: Identifiable, Codable {
    var id: String?
    let info: Info
    let players: [Player]
    var competitionTable: CompetitionTable?
    
    var dictionary: [String: Any] {
        return [
            "info": info.dictionary,
            "players": players.map{ $0.dictionary },
            "competitionTable": competitionTable!.dictionary
        ]
    }
    
    init(info: Info, players: [Player]) {
        self.info = info
        self.players = players
        self.competitionTable = CompetitionTable(playersArray: self.players)
    }
    
}
