//
//  UIColor+Extention.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 02.10.2022.
//

import UIKit

extension UIColor {
    
    static var backgroundColor: UIColor? {
        guard let color = UIColor(named: "backgroundColor") else {
            print("Something wrong with color in Assets")
            return nil
        }
        return color
    }
    
    static var anyColor: UIColor{
        #colorLiteral(red: 0.4745098039, green: 0.9215686275, blue: 0.4666666667, alpha: 1)
    }
    
    static var anyColor1: UIColor{
        #colorLiteral(red: 0.8862745098, green: 0.8274509804, blue: 1, alpha: 1)
    }
    
    
    
    static var anyDarckColor: UIColor{
        #colorLiteral(red: 0.1411764706, green: 0.1882352941, blue: 0.368627451, alpha: 1)
    }
}
