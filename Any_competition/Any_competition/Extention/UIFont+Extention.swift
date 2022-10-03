//
//  UIFont+Extention.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 27.09.2022.
//

import UIKit

extension UIFont {
    
    static var anyCompLargeFont: UIFont {
        let font = UIFont(name: "Diary-of-an-8-bit-mage", size: 24)
//        let font = UIFont(name: "Hardpixel", size: 24)
        return font!
    }

    static var anyCompMediumFont: UIFont {
        let font = UIFont(name: "Diary-of-an-8-bit-mage", size: 18)
//        let font = UIFont(name: "Hardpixel", size: 18)
        return font!
    }
    static var anyCompSmallFont: UIFont {
        let font = UIFont(name: "Diary-of-an-8-bit-mage", size: 8)
//        let font = UIFont(name: "Hardpixel", size: 8)
        return font!
    }


}
