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
    
    static func standard(size: CGFloat, weight: CGFloat, width: CGFloat = 86) -> Font {
        Font(uiFont: .standard(size, axis: [.weight: 100, .width: width])).weight(.init(customWeight: weight))
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

import UIKit

public enum FontVariations: Int, CustomStringConvertible {
    // Magic numbers for the various axes available for variable font control
    case weight = 2003265652
    case width = 2003072104
    case opticalSize = 1869640570
    case grad = 1196572996
    case slant = 1936486004
    case xtra = 1481921089
    case xopq = 1481592913
    case yopq = 1498370129
    case ytlc = 1498696771
    case ytuc = 1498699075
    case ytas = 1498693971
    case ytde = 1498694725
    case ytfi = 1498695241

    public var description: String {
        switch self {
        case .weight:
            return "Weight"
        case .width:
            return "Width"
        case .opticalSize:
            return "Optical Size"
        case .grad:
            return "Grad"
        case .slant:
            return "Slant"
        case .xtra:
            return "Xtra"
        case .xopq:
            return "Xopq"
        case .yopq:
            return "Yopq"
        case .ytlc:
            return "Ytlc"
        case .ytuc:
            return "Ytuc"
        case .ytas:
            return "Ytas"
        case .ytde:
            return "Ytde"
        case .ytfi:
            return "Ytfi"
        }
    }
}

public extension UIFont {
    static func standard(_ size: CGFloat, axis: [FontVariations: Double] = [:]) -> UIFont {
        let variationAttributes = axis.map { key, value in
            [UIFontDescriptor.FeatureKey(rawValue: String(key.rawValue)): value]
        }

        let fontDescriptor = UIFontDescriptor(name: "Antarctica", size: size).addingAttributes([
            UIFontDescriptor.AttributeName.featureSettings: variationAttributes
        ])
        
        return UIFont(descriptor: fontDescriptor, size: size)
    }
}
