//
//  UIColor+Hexadecimal.swift
//  CoreTodo
//
//  Created by Yujin Kim on 2023-09-15.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexadecimalFormat: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if hexadecimalFormat.hasPrefix("#") {
            hexadecimalFormat = String(hexadecimalFormat.dropFirst())
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexadecimalFormat).scanHexInt64(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x0FF0) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
