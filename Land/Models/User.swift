//
//  User.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID().uuidString
    let username: String
    let name: String
    let instagramUsername: String?
    let twitterUsername: String?
    let websiteUrl: String?
    let location: String?
    let bio: String?
    let imageData: Data?
}
