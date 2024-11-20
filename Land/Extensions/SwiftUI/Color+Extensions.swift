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
}
