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
//                    GeometryReader {
//                        let size = $0.size
                        
                        item.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
//                            .frame(width: size.width)
                            .clipShape(.rect(cornerRadius: 24))
//                    }
                    .matchedGeometryEffect(id: item.id + "ARTWORK", in: animation)
                }
            }
//            .frame(height: 245)
            
            if !expandSheet {
                HStack {
                    Text(item.description)
                        .font(.standard(size: 10, weight: 360))
                        .lineLimit(1)
                        .foregroundStyle(Color.custom(hex: "666666"))
                        .frame(height: .heightForFontSize(size: 16))
                    Spacer(minLength: 0)
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 10))
                        .foregroundStyle(.black)
                        .frame(height: 16)
                        .frame(width: 65, alignment: .trailing)
                        .background {
                            LinearGradient(colors: [.white, .white.opacity(0)], startPoint: .trailing, endPoint: .leading)
                        }
                }
            }
            
        }
        .contentShape(.rect)
    }
}

#Preview {
    @Previewable @Namespace var animation
    @Previewable @State var expandSheet = false
    ItemCellView(expandSheet: $expandSheet, animation: animation, item: sampleImages.first!)
        .frame(width: UIScreen.main.bounds.width / 2, alignment: .leading)
        .padding()
}
