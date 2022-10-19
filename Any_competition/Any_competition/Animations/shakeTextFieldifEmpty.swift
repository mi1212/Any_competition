//
//  shakeTextFieldifEmpty.swift
//  Any_competition
//
//  Created by Mikhail Chuparnov on 08.10.2022.
//

import UIKit

func shakeTextFieldifEmpty(_ textField: UITextField){
    if textField.text == "" {
        textField.backgroundColor = .systemRed
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
    } else {
        textField.backgroundColor = .white
    }
}
