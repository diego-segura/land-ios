//
//  Font+Custom.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

extension Font {
    private init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
    
    static func standard(size: CGFloat, weight: CGFloat) -> Font {
        Font.custom("AntarcticaVAR-Regular", size: size)
            .weight(Font.Weight(customWeight: weight))
    }
}

extension Font.Weight {
    init(customWeight: CGFloat) {
        switch customWeight {
        case ...100:
            self = .thin
        case 101...200:
            self = .ultraLight
        case 201...311:
            self = .light
        case 312...400:
            self = .regular
        case 401...500:
            self = .medium
        case 501...600:
            self = .semibold
        case 601...700:
            self = .bold
        case 701...800:
            self = .heavy
        case 801...:
            self = .black
        default:
            self = .regular
        }
    }
}
