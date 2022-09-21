//
//  CompetitionModel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation

struct Competition: Identifiable, Codable  {
    let id: String?
    let title: String
    let qtyPlayers: Int
    let sportType: String
//    let players: [Player]
}
