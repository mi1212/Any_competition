//
//  PlayersTable.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 27.09.2022.
//

import Foundation

class PlayersTable {
    
    var playersArray: [Player]
    var matchesTable = [Player: [Match]]()
    
    
    init(playersArray: [Player]) {
        self.playersArray = playersArray
        createMatchesTable(playersArray)
    }
    
    private func createMatchesTable(_ playersArray: [Player]) -> [Player: [Match]] {
        
        var matchesTable = [Player: [Match]]()
        
        var matchArray = [Match]()
        
        for i in 0...playersArray.count - 1 {
            
            let player = playersArray[i]
            
            for opponent in 0...playersArray.count - 1 {
                let match = Match(player1: player, player2: playersArray[opponent], isDone: false)
                matchArray.append(match)
            }
            print(matchArray)
            matchesTable[player] = matchArray
            matchArray = [Match]()
        }
        return matchesTable
    }
}
