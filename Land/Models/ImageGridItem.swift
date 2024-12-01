//
//  ImageGridItem.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

struct ImageGridEntity: Codable, Hashable, Identifiable {
    let id: String
    let title: String
    let description: String
    let imageData: Data
}
