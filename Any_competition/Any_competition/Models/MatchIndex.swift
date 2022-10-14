//
//  MatchIndex.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 13.10.2022.
//

import Foundation

struct MatchIndex: Codable {
    let indexOfPlayer: Int
    let indexOfMatch: Int
    
    var dictionary: [String: Any] {
        return [
            "indexOfPlayer": indexOfPlayer,
            "indexOfMatch": indexOfMatch
        ]
    }
    
    init(_ indexOfPlayer: Int, _ indexOfMatch: Int) {
        self.indexOfPlayer = indexOfPlayer
        self.indexOfMatch = indexOfMatch
    }
}
