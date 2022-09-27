//
//  UsersTable.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 27.09.2022.
//

import Foundation

class UsersTable {
    
    var playersArray: [Player]?
    
    var competitionPlayersArray: [String: [Bool]] = [:]

    init(playersArray: [Player]) {
        self.playersArray = playersArray
        createCompetitionPlayersArray()
    }
    
    private func createCompetitionPlayersArray() {
   
        for i in 0...playersArray!.count - 1 {
            competitionPlayersArray[playersArray![i].name + " " + playersArray![i].secondName] = [Bool](repeating: false, count: playersArray!.count)
        }
        
        print(competitionPlayersArray)
 
    }
}
