//
//  MatchIndex.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 13.10.2022.
//

import Foundation

struct MatchIndex {
    let indexOfPlayer: Int
    let indexOfMatch: Int
    
    init(_ indexOfPlayer: Int, _ indexOfMatch: Int) {
        self.indexOfPlayer = indexOfPlayer
        self.indexOfMatch = indexOfMatch
    }
}
