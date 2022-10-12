//
//  PlayersTable.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 27.09.2022.
//

import Foundation

class CompetitionTable {
    
    var playersArray: [Player]
    
    var competitionTable = [Player: [Match]]()
 
    init(playersArray: [Player]) {
        self.playersArray = playersArray
        createCompetitionTable(playersArray)
    }
    
    private func createCompetitionTable(_ playersArray: [Player]) -> [Player: [Match]] {
        
        var competitionTable = [Player: [Match]]()
        
        var matchArray = [Match]()
        
        for i in 0...playersArray.count - 1 {
            
            let player = playersArray[i]
            
            for opponent in 0...playersArray.count - 1 {
                let match = Match(player1: player, player2: playersArray[opponent], isDone: false)
                matchArray.append(match)
            }
            print(matchArray)
            competitionTable[player] = matchArray
            matchArray = [Match]()
        }
        return competitionTable
    }
    
    public func finishMatch(match: Match, winningPlayer: Player, losedPlayer: Player) {}
}
