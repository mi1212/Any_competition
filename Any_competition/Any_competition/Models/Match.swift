//
//  Match.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 10.10.2022.
//

import Foundation

struct Match: Codable {
    let player1: User
    let player2: User
    var isDone = false
    var isWinned = false
    var scorePlayer1: Int = 0
    var scorePlayer2: Int = 0
    var matchIndex: MatchIndex
    
    init(player1: User, player2: User, matchIndex: MatchIndex) {
        self.player1 = player1
        self.player2 = player2
        self.matchIndex = matchIndex
    }
    
    var dictionary: [String: Any] {
        return [
            "player1": player1.dictionary,
            "player2": player2.dictionary,
            "isDone": isDone,
            "isWinned": isWinned,
            "scorePlayer1": scorePlayer1,
            "scorePlayer2": scorePlayer2,
            "matchIndex": matchIndex.dictionary,
        ]
    }
    
    mutating func makeMatch(_ scorePlayer1: Int,_ scorePlayer2: Int) {
        if !isDone {
            self.scorePlayer1 = scorePlayer1
            self.scorePlayer2 = scorePlayer2
            
            self.isDone = true
            
            if scorePlayer1 > scorePlayer2 {
                self.isWinned = true
            } else {
                self.isWinned = false
            }
        } else {
            return
        }
    }
    
    func makeMirrorMatch(match: Match) -> Match {
        var mirrorMatch = Match(player1: match.player2, player2: match.player1, matchIndex: MatchIndex(match.matchIndex.indexOfMatch, match.matchIndex.indexOfPlayer))
        mirrorMatch.isDone = match.isDone
        mirrorMatch.scorePlayer1 = match.scorePlayer2
        mirrorMatch.scorePlayer2 = match.scorePlayer1
        
        if mirrorMatch.scorePlayer1 > mirrorMatch.scorePlayer2 {
            mirrorMatch.isWinned = true
        } else {
            mirrorMatch.isWinned = false
        }
        
        return mirrorMatch
    }
}
