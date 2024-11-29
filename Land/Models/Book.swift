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
    let description: String
    var items: [GridItem]
}

let sampleBooks: [Book] = [
    Book(
        name: "camera roll",
        description: "from my camera roll",
        items: [
            .text(TextGridItem(text: lipsum))
        ]
    ),
    Book(name: "thoughts", description: "the person who thinks all the time...", items: []),
]

private let lipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
