//
//  Home.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

struct Home: View {
    
    @State var items: [Item] = sampleImages
    @State private var selectedItem: Item?
    @State private var animateView: Bool = false
    @State private var titleItemSize: CGSize = .zero
    @Namespace private var animation
    
    var body: some View {
        ScrollView(.vertical) {
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 30) {
                    header
                        .padding(.horizontal, 32)
                    
                    HStack {
                        Button("edit profile") {
                            
                        }
                        .buttonStyle(.standard)
                        Button("copy your link") {
                            
                        }
                        .buttonStyle(.highlighted)
                    }
                    .padding(.horizontal, 16)
                }
                Divider()
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                    ForEach($items) { $item in
                        itemView(item)
                            .frame(height: 160)
                            .onTapGesture {
                                guard selectedItem == nil else { return }
                                
                                selectedItem = item
                                withAnimation(noteAnimation) {
                                    animateView = true
                                }
                            }
                    }
                }
                .safeAreaPadding(8)
            }
        }
        .allowsHitTesting(selectedItem == nil)
        .overlay {
            GeometryReader {
                let size = $0.size
                
                ForEach(items) { item in
                    if item.id == selectedItem?.id && animateView {
                        ItemDetailView(
                            size: size,
                            titleItemSize: titleItemSize,
                            animation: animation,
                            item: item
                        ) {
                            if selectedItem != nil {
                                withAnimation(noteAnimation.logicallyComplete(after: 0.1)) {
                                    animateView = false
                                    selectedItem = nil
                                }
                            }
                        }
                        .transition(.blurReplace)
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
    
    func itemView(_ item: Item) -> some View {
        ZStack {
            if selectedItem?.id == item.id && animateView {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .overlay {
                        TitleItemView(size: titleItemSize, item: item)
                    }
                    .matchedGeometryEffect(id: item.id, in: animation)
            }
        }
        .onGeometryChange(for: CGSize.self) {
            $0.size
        } action: { newValue in
            titleItemSize = newValue
        }
    }
    
    var header: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("diego segura")
                        .font(.standard(size: 24, weight: 310))
                        .frame(height: .heightForFontSize(size: 24))
                        .kerning(-0.24)
                    Text("@messybirkin")
                        .font(.standard(size: 14, weight: 420))
                        .frame(height: .heightForFontSize(size: 14))
                        .kerning(-0.14)
                        .opacity(0.4)
                }
                Spacer()
                Image(.me1)
                    .clipShape(.circle)
            }
            Text("founder + designer at Land. i love long walks in the concrete jungle. 40,000+ McDonald’s Rewards Points.")
                .font(.standard(size: 14, weight: 360))
                .kerning(-0.14)
                .foregroundStyle(Color.custom(hex: "666666"))
                .padding(.trailing, 16)
            
            HStack(spacing: 15) {
                Image(systemName: "link")
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                Image(.instagram)
                Image(.twitter)
            }
        }
    }
}

#Preview {
    ContentView()
}
