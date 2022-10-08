//
//  ShakeAnimation.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 08.10.2022.
//

import UIKit

func shake(_ animatedView: UIView){
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 3
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: animatedView.center.x - 10, y: animatedView.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: animatedView.center.x + 10, y: animatedView.center.y))
    animatedView.layer.add(animation, forKey: "position")
}
