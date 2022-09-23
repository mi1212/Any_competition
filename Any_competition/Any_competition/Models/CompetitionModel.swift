//
//  CompetitionModel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation

struct Competition: Codable {
    let title: String
    let qtyPlayers: Int
    let sportType: String
//    let players: [Player]
    let date: Date
    
    var dictionary: [String: Any] {
            return["title": title,
                   "qtyPlayers": qtyPlayers,
                   "sportType": sportType,
//                   "players": players,
                   "date": date]
        }
}
