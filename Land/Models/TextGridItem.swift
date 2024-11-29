//
//  TextGridItem.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import SwiftUI

struct TextGridItem: Codable, Hashable, Identifiable {
    let id: String = UUID().uuidString
    let text: String
}
