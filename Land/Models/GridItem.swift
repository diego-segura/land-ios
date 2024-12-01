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
    
    var timeStamp: Date {
        switch self {
        case .image(let image):
            image.timeStamp
        case .text(let text):
            text.timeStamp
        case .link:
            Date()
        }
    }
    
    var description: String {
        get {
            switch self {
            case .image(let image):
                return image.title
            case .text(let text):
                return text.description
            case .link:
                return ""
            }
        }
        set {
            switch self {
            case .image(var image):
                image.title = newValue
                self = .image(image) // Update and reassign the case
            case .text(var text):
                text.description = newValue
                self = .text(text) // Update and reassign the case
            case .link:
                // Optional: Handle a default description for .link
                print("Cannot set description for link")
            }
        }
    }
}
