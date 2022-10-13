//
//  PlayersTable.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 27.09.2022.
//

import Foundation

struct CompetitionTable {
    
    var playersArray: [Player]
    
    var competitionTable = [[Match]]()
 
    var qtyPlayers = 0
    
    var qtyGames = 0
    
    var isCompetitionFinished = false
    
    init(playersArray: [Player]) {
        self.playersArray = playersArray
        competitionTable = createCompetitionTable(playersArray)
        qtyPlayers = playersArray.count
        qtyGames = qtyGames*qtyGames - qtyGames
    }
    
    private func createCompetitionTable(_ playersArray: [Player]) -> [[Match]] {
        
        var competitionTable = [[Match]]()
        var matchArray = [Match]()
        
        for i in 0...playersArray.count - 1 {
            let player = playersArray[i]
            for j in 0...playersArray.count - 1 {
                let match = Match(player1: player, player2: playersArray[j], matchIndex: MatchIndex(i, j))
                matchArray.append(match)
            }
            competitionTable.append(matchArray)
            matchArray = [Match]()
        }
        
        return competitionTable
    }
    
    public mutating func finishMatch(_ match: Match) {
        
        let index = match.matchIndex
        
        competitionTable[index.indexOfPlayer][index.indexOfMatch] = match
        
        print(competitionTable[index.indexOfPlayer][index.indexOfMatch])
        
    }
}
