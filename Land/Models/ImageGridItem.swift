//
//  ImageGridItem.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

struct ImageGridEntity: Codable, Hashable, Identifiable {
    let id: String
    var title: String
    let imageData: Data
    let timeStamp: Date
}
