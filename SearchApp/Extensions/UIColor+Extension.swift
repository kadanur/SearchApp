//
//  UIColor+Extension.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 9.05.2022.
//

import UIKit

public extension UIColor {

    convenience init(hexRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hexRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    convenience init(hexRGBString: String?, alpha: CGFloat = 1.0) {
        if let intString = hexRGBString?.replacingOccurrences(of: "#", with: ""),
           let hex = UInt(intString, radix: 16) {
            self.init(hexRGB: hex, alpha: alpha)
        } else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    
}
