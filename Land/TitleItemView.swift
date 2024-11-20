//
//  TitleItemView.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

struct TitleItemView: View {
    var size: CGSize
    var item: Item
    var body: some View {
        item.image
            .resizable()
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .clipShape(.rect(cornerRadius: 10))
    }
}
