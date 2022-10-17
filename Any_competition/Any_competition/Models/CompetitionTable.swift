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

        let matchMirror = match.makeMirrorMatch(match: match)
        
        competitionTable[match.matchIndex.indexOfPlayer].matchesOfPlayer[match.matchIndex.indexOfMatch] = match
        
        competitionTable[matchMirror.matchIndex.indexOfPlayer].matchesOfPlayer[matchMirror.matchIndex.indexOfMatch] = matchMirror
        
        qtyFinishedGames += 1
        
        checkFinish(qtyFinishedGames: qtyFinishedGames)
    }
    
    mutating func checkFinish(qtyFinishedGames: Int) {
        if qtyFinishedGames == qtyGames {
            isCompetitionFinished = true
            print("--- competition was finished")
        }
    }
    
    func calculatePointsOfPlayer(_ player: Player) -> Int {
        var points = 0
        let playerNumber = player.number
        for i in 0...competitionTable[playerNumber].matchesOfPlayer.count-1 {
            switch competitionTable[playerNumber].matchesOfPlayer[i].isWinned {
            case true:
                points += 3
            case false:
                points += 0
            }
        }
        
        
        return points
    }
}
