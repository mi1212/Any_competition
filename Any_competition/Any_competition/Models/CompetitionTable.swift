//
//  PlayersTable.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 27.09.2022.
//

import Foundation

struct CompetitionTable: Codable {
    
    var playersArray: [Player]
    
    var competitionTable = [MatchesOfPlayer]()
 
    var qtyPlayers = 0
    
    var qtyGames = 0
    
    var qtyFinishedGames = 0
    
    var isCompetitionFinished = false
    
    var dictionary: [String: Any] {
        return [
            "playersArray": playersArray.map{ $0.dictionary },
            "competitionTable": competitionTable.map { $0.dictionary},
            "qtyPlayers": qtyPlayers,
            "qtyGames": qtyGames,
            "qtyFinishedGames": qtyFinishedGames,
            "isCompetitionFinished": isCompetitionFinished
        ]
    }
    
    init(playersArray: [Player]) {
        self.playersArray = playersArray
        competitionTable = createCompetitionTable(playersArray)
        qtyPlayers = playersArray.count
        self.qtyGames = (qtyPlayers*qtyPlayers - qtyPlayers)/2
    }
    
    private func createCompetitionTable(_ playersArray: [Player]) -> [MatchesOfPlayer] {
        
        var competitionTable = [MatchesOfPlayer]()
        var matchArray = [Match]()
        
        for i in 0...playersArray.count - 1 {
            let player = playersArray[i]
            for j in 0...playersArray.count - 1 {
                let match = Match(player1: player, player2: playersArray[j], matchIndex: MatchIndex(i, j))
                matchArray.append(match)
            }
            competitionTable.append(MatchesOfPlayer(matchesOfPlayer: matchArray))
            matchArray = [Match]()
        }
        
        return competitionTable
    }
    
    public mutating func finishMatch(_ match: Match) {

        let matchMirror = Match(match)
        
        competitionTable[match.matchIndex.indexOfPlayer].matchesOfPlayer[match.matchIndex.indexOfMatch] = match
        
        competitionTable[matchMirror.matchIndex.indexOfPlayer].matchesOfPlayer[matchMirror.matchIndex.indexOfMatch] = matchMirror
        
        qtyFinishedGames += 1
        
        print("qtyFinishedGames - \(qtyFinishedGames), qtyGames - \(qtyGames)")
        
        checkFinish(qtyFinishedGames: qtyFinishedGames)
    }
    
    mutating func checkFinish(qtyFinishedGames: Int) {
        
        if qtyFinishedGames == qtyGames {
            isCompetitionFinished = true
            print("competition was finished")
        }
    }
}
