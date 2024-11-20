//
//  CGFloat+Extension.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

extension CGFloat {
    static func heightForFontSize(size: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: size)
        return font.capHeight
    }
}
