//
//  Book.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import Foundation

struct Book: Codable, Identifiable {
    var id = UUID().uuidString
    let name: String
    var items: [GridItem]
}

extension Book {
    func firstImage() -> ImageGridEntity? {
        for item in items {
            if case .image(let imageEntity) = item {
                return imageEntity
            }
        }
        return nil
    }
}
