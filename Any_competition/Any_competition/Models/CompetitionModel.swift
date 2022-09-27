//
//  CompetitionModel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation
import FirebaseFirestore

struct Competition: Codable {
    let info: Info
    let players: [Player]
    
}

struct Info: Codable {
    let title: String
    let qtyPlayers: Int
    let sportType: String
    let date: String
    
    var dictionary: [String: Any] {
        return[
            "title": title,
            "qtyPlayers": qtyPlayers,
            "sportType": sportType,
            "date": date
        ]
    }
}

struct Player: Codable {
    var name: String
    var secondName: String
    
    var dictionary: [String: Any] {
        return["name": name,
               "secondName": secondName]
    }
}
