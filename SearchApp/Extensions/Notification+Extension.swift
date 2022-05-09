//
//  Notification+Extension.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import UIKit

public extension Notification {
    
    func getKeyboardAnimationData() -> (TimeInterval, UIView.AnimationOptions, CGFloat) {
        var animDuration: TimeInterval = 0.25
        var animOption: UIView.AnimationOptions = .curveEaseInOut
        var keyboardHeight: CGFloat = 0.0
        if let userInf = self.userInfo,
            let animationDuration = userInf[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let animationCurveInt = userInf[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
            let frameEndUser = userInf[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            animDuration = TimeInterval(animationDuration)
            if let animationCurve = UIView.AnimationCurve(rawValue: animationCurveInt) {
                switch animationCurve {
                case .easeInOut:
                    animOption = .curveEaseInOut
                case .easeIn:
                    animOption = .curveEaseIn
                case .easeOut:
                    animOption = .curveEaseOut
                case .linear:
                    animOption = .curveLinear
                default:
                    animOption = .curveEaseOut
                }
            }
            keyboardHeight = frameEndUser.size.height
        }
        return (animDuration, animOption, keyboardHeight)
    }
    
}
