//
//  GridItem.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import Foundation

enum GridItem: Codable, Equatable, Hashable, Identifiable {
    case image(ImageGridEntity)
    case text(TextGridItem)
    case link
    
    var id: String {
        switch self {
        case .image(let image):
            image.id
        case .text(let text):
            text.id
        case .link:
            ""
        }
    }
}
