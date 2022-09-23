//
//  UserModel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation

struct Player: Codable {
    var name: String
    var secondName: String
    
    var dictionary: [String: Any] {
            return["name": name,
                   "secondName": secondName]
        }
  }
