//
//  Item.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

import SwiftUI

struct Item: Identifiable {
    private(set) var id: UUID = .init()
    var title: String
    var description: String
    var image: Image
}

var sampleImages: [Item] = [
    .init(title: "Abril Altamirano", description: "river and lake behind", image: Image(.pic1)),
    .init(title: "Gülşah Aydoğan", description: "hot air balloons flying in Cappadocia at sunrise", image: Image(.pic2)),
    .init(title: "Melike Sayar Melikesayar", description: "winter landscape with wooden cottage in snowy forest", image: Image(.pic3)),
    .init(title: "Maahid Photos", description: "branches with green leaves in nature", image: Image(.pic4)),
    .init(title: "Pelageia Zelenina", description: "bush with green fern leaves", image: Image(.pic5)),
    .init(title: "Ofir Eliav", description: "Golden sunset over a tranquil forest clearing.", image: Image(.pic6)),
    .init(title: "Melike Sayar Melikesayar", description: "tree growing among agricultural field in countryside", image: Image(.pic7)),
    .init(title: "Melike Sayar Melikesayar", description: "scenic landscape of autumn forest with tall trees in fog", image: Image(.pic8))
]
