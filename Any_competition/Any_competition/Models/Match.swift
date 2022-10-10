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
    var score = [Player: Int]()
    
    init(player1: Player, player2: Player, isDone: Bool) {
        self.player1 = player1
        self.player2 = player2
        self.isDone = isDone
    }
    
    private mutating func makeMatch(player1: Player, player2: Player) {
        self.score[player1] = 0
        self.score[player2] = 0
    }
}
