//
//  ItemCellView.swift
//  Land
//
//  Created by Luka Vujnovac on 21.11.2024..
//

import SwiftUI

struct ItemCellView: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        
                        item.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(.rect(cornerRadius: 24))
                    }
                    .matchedGeometryEffect(id: item.id + "ARTWORK", in: animation)
                }
            }
            .frame(height: 245)
        }
        .contentShape(.rect)
    }
}

#Preview {
    @Previewable @Namespace var animation
    @Previewable @State var expandSheet = false
    ItemCellView(expandSheet: $expandSheet, animation: animation, item: sampleImages.first!)
}
