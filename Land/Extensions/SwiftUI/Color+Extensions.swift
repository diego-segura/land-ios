//
//  Color+Extensions.swift
//  Land
//
//  Created by Luka Vujnovac on 18.11.2024..
//

import SwiftUI

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        let hexString = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        
        guard hexString.count == 6 else {
            self = Color.gray
            return
        }
        
        let scanner = Scanner(string: hexString)
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        
        let red = Double((hexValue >> 16) & 0xFF) / 255.0
        let green = Double((hexValue >> 8) & 0xFF) / 255.0
        let blue = Double(hexValue & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static func custom(hex: String) -> Color {
        Color(hex: hex)
    }
    
    func toHex() -> String {
        guard let components = UIColor(self).cgColor.components else {
            return "FFFFFF"
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    func textColor() -> Color {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
            return .black
        }
        
        let r = components[0]
        let g = components[1]
        let b = components[2]
        
        let yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000
        
        return yiq >= 0.5 ? .black : .white
    }
}
