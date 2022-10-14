//
//  MatchesOfPlayer.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 14.10.2022.
//

import Foundation

struct MatchesOfPlayer: Codable {
    var matchesOfPlayer: [Match]
    
    var dictionary: [String: Any] {
        return [
            "matchesOfPlayer" : matchesOfPlayer.map { $0.dictionary }
        ]
    }
}
