//
//  Match.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 10.10.2022.
//

import Foundation

struct Match: Codable {
    let player1: Player
    let player2: Player
    var isDone = false
    var isWinned = false
    var scorePlayer1: Int = 0
    var scorePlayer2: Int = 0
    var matchIndex: MatchIndex
    
    init(player1: Player, player2: Player, matchIndex: MatchIndex) {
        self.player1 = player1
        self.player2 = player2
        self.matchIndex = matchIndex
    }
    
    init(_ matchMirror: Match) {
        self.player1 = matchMirror.player2
        self.player2 = matchMirror.player1
        self.scorePlayer2 = self.scorePlayer1
        self.scorePlayer1 = self.scorePlayer2
        self.isDone.toggle()
        self.isWinned = matchMirror.isWinned
        self.isWinned.toggle()
        self.matchIndex = MatchIndex(matchMirror.matchIndex.indexOfPlayer, matchMirror.matchIndex.indexOfPlayer)
    }
    
    var dictionary: [String: Any] {
        return [
            "player1": player1.dictionary,
            "player2": player2.dictionary,
            "isDone": isDone,
            "isWinned": isDone,
            "scorePlayer1": scorePlayer1,
            "scorePlayer2": scorePlayer2,
            "matchIndex": matchIndex.dictionary,
        ]
    }
    
    mutating func makeMatch(_ scorePlayer1: Int,_ scorePlayer2: Int) {
        if !isDone {
            self.scorePlayer1 = scorePlayer1
            self.scorePlayer2 = scorePlayer2
            
            self.isDone.toggle()
            
            if scorePlayer1 > scorePlayer2 {
                self.isWinned.toggle()
            }
        } else {
            return
        }
    }
}
