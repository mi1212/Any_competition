//
//  Info.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 10.10.2022.
//

import Foundation

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