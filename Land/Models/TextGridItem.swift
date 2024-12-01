//
//  TextGridItem.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import Foundation

struct TextGridItem: Codable, Hashable, Identifiable {
    let id: String
    let text: String
    let timeStamp: Date
    var description: String
}
