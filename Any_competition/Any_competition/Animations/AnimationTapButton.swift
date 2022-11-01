//
//  AnimationTapButton.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 01.11.2022.
//

import UIKit

func animationTapButton(_ button: UIButton){
    
    let time = 0.1
    
    let scale = 0.95
    
    UIView.animate(withDuration: time, delay: 0) {
        button.transform = button.transform.scaledBy(x: scale, y: scale)
    } completion: { handler in
        UIView.animate(withDuration: time, delay: 0) {
            button.transform = button.transform.scaledBy(x: 1/scale, y: 1/scale)
        } completion: { handler in
            
        }
    }
}
