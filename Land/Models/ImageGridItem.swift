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
    
//    func toModel() -> ImageGridItem {
//        ImageGridItem(
//            title: title,
//            description: description,
//            image: Image(
//                uiImage: UIImage(data: imageData) ?? UIImage())
//        )
//    }
}

//struct ImageGridItem: Identifiable, Equatable, Hashable {
//    private(set) var id: String = UUID().uuidString
//    var title: String
//    var description: String
//    var image: Image
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    @MainActor
//    func toEntity() -> ImageGridEntity {
//        ImageGridEntity(id: id, title: title, description: description, imageData: ImageRenderer(content: image).uiImage?.pngData() ?? Data())
//    }
//}
//
//var sampleImages: [ImageGridItem] = [
//    .init(title: "Abril Altamirano", description: "river and lake behind, hot air balloons flying in Cappadocia at sunrise", image: Image(.pic1)),
//    .init(title: "Gülşah Aydoğan", description: "hot air balloons flying in Cappadocia at sunrise", image: Image(.pic2)),
//    .init(title: "Melike Sayar Melikesayar", description: "winter landscape with wooden cottage in snowy forest", image: Image(.pic3)),
//    .init(title: "Melike Sayar Melikesayar", description: "coolest Marvel dude", image: Image(.pic9)),
//    .init(title: "Maahid Photos", description: "branches with green leaves in nature", image: Image(.pic4)),
//    .init(title: "Pelageia Zelenina", description: "bush with green fern leaves", image: Image(.pic5)),
//    .init(title: "Ofir Eliav", description: "Golden sunset over a tranquil forest clearing.", image: Image(.pic6)),
//    .init(title: "Melike Sayar Melikesayar", description: "tree growing among agricultural field in countryside", image: Image(.pic7)),
//    .init(title: "Melike Sayar Melikesayar", description: "scenic landscape of autumn forest with tall trees in fog", image: Image(.pic8)),
//]
//
//var gridItems: [ImageGridItem] = [
//    .init(title: "Abril Altamirano", description: "river and lake behind", image: Image("post1")),
//    .init(title: "Gülşah Aydoğan", description: "hot air balloons flying in Cappadocia at sunrise", image: Image("post2")),
//    .init(title: "Melike Sayar Melikesayar", description: "winter landscape with wooden cottage in snowy forest", image: Image("post3")),
//    .init(title: "Maahid Photos", description: "branches with green leaves in nature", image: Image("post4")),
//    .init(title: "Pelageia Zelenina", description: "bush with green fern leaves", image: Image("post5")),
//    .init(title: "Ofir Eliav", description: "Golden sunset over a tranquil forest clearing.", image: Image("post6")),
//    .init(title: "Melike Sayar Melikesayar", description: "tree growing among agricultural field in countryside", image: Image("post7")),
//    .init(title: "Melike Sayar Melikesayar", description: "scenic landscape of autumn forest with tall trees in fog", image: Image("post8")),
//    .init(title: "New Photographer", description: "majestic mountains with clear blue sky", image: Image("post9")),
//    .init(title: "Another Photographer", description: "city skyline during golden hour", image: Image("post10"))
//]
