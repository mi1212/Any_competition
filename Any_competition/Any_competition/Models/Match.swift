//
//  Match.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 10.10.2022.
//

import Foundation

struct Match {
    let player1: Player
    let player2: Player
    var isDone: Bool = false
    var scorePlayer1: Int = 0
    var scorePlayer2: Int = 0
    var matchIndex: MatchIndex
    
    init(player1: Player, player2: Player, matchIndex: MatchIndex) {
        self.player1 = player1
        self.player2 = player2
        self.matchIndex = matchIndex
    }
    
//    private mutating func makeMatch(player1: Player, player2: Player) {
//        self.score[player1] = 0
//        self.score[player2] = 0
//    }
}
