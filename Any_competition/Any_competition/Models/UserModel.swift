//
//  UserModel.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 21.09.2022.
//

import Foundation

struct Player: Identifiable, Codable {
    var id: String?
    var name: String
    var secondName: String
    var email: String?
  }
