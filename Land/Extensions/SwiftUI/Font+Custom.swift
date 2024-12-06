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
    
    static func standard(size: CGFloat) -> Font {
        Font.custom("AntarcticaVAR-Regular", size: size)
    }
    
    static func standard(size: CGFloat, weight: CGFloat) -> Font {
        Font.custom("AntarcticaVAR-Regular", size: size)
            .weight(Font.Weight(customWeight: weight))
    }
}

extension Font.Weight {
    init(customWeight: CGFloat) {
        switch customWeight {
        case ...150:
            self = .ultraLight
        case 151...250:
            self = .thin
        case 251...350:
            self = .light
        case 351...450:
            self = .regular
        case 451...550:
            self = .medium
        case 551...650:
            self = .semibold
        case 651...750:
            self = .bold
        case 751...850:
            self = .heavy
        case 851...:
            self = .black
        default:
            self = .regular
        }
    }
}

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

public extension Font {
    static func standard(_ size: UIFont.TextStyle = .body, weight: Font.Weight = .regular) -> Font {

        let weightCGFloat: CGFloat = switch weight {
        case .light:
            310
        case .regular:
            360
        case .medium:
            420
        case .semibold:
            480
        case .bold:
            540
        default:
            360
        }
        
        let intAxis: [Int: CGFloat] = [
            FontVariations.weight.rawValue: weightCGFloat,
            FontVariations.width.rawValue: 86
        ]
        
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            .name: "AntarcticaVAR-Regular",
            kCTFontVariationAttribute as UIFontDescriptor.AttributeName: intAxis
        ])
        
        return Font(.init(fontDescriptor, size: UIFont.preferredFont(forTextStyle: size).pointSize))
    }
    
    static func standard(_ size: CGFloat, axis: [FontVariations: CGFloat] = [:]) -> Font {

        let intAxis: [Int: CGFloat] = .init(uniqueKeysWithValues: axis.map { (key, value) in
            return (key.rawValue, value)
        })
        
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            .name: "AntarcticaVAR-Regular",
            kCTFontVariationAttribute as UIFontDescriptor.AttributeName: intAxis,
        ])
        
        return Font(.init(fontDescriptor, size: size))
    }
}

#Preview {
    VStack(alignment:.leading, spacing: 20) {
        ForEach(Array(stride(from: 200, to: 600, by: 50)), id: \.self) { weight in
            Text("""
            Antarctica \(weight.formatted())
            Types to they that be of the craft are as things that be alive.
            """)
            .font(.standard(
                UIFont.preferredFont(forTextStyle: .callout).pointSize,
                axis: [
                    .weight: CGFloat(weight),
                    .width: 86,
                ]
            )) 
        }
    }
    .padding()
}
