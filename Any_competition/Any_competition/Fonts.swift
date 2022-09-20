//
//  Fonts.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 20.09.2022.
//

import UIKit

class CompetitionFonts {
    
    var customFont: UIFont {
        guard let customFont = UIFont(name: "8BIT WONDER", size: 36) else {
            fatalError("""
                    Failed to load the "tight_pixel" font.
                    Make sure the font file is included in the project and the font name is spelled correctly.
                    """
            )
        }
        return customFont
    }
    
    init () {}
    
}
