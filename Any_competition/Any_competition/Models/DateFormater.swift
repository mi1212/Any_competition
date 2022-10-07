//
//  DateFormater.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 07.10.2022.
//

import UIKit

func dateFormater(_ dateString: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    
    let date = dateFormatter.date(from: dateString)
    
    return (date?.formatted(date: .abbreviated, time: .omitted))!
    
}
