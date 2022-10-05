//
//  CompetitionData.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 05.10.2022.
//

import Foundation

struct CompetitionData {
    let qty: Int
    
    let players: [Player]
    
    let competitionTable: [Int]
    
}

struct CompetitionTable {
    
}

struct Match {
    let user1: Player
    
    let user2: Player
    
    let isPlayed: Bool
    
    let score: [Int]
}
