//
//  Home.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

struct Home: View {
    
    @State var items: [Item] = sampleImages
    @State private var hideItem: Item?
    @State private var animateView: Bool = false
    @State private var titleItemSize: CGSize = .zero
    
    @State private var expandSheet: Bool = false
    @State private var selectedItem: Item?
    @State private var blurBackground = false
    
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
                        itemView(item: item)
                    }
                }
                .safeAreaPadding(8)
            }
        }
        .blur(radius: expandSheet ? 20 : 0)
        .opacity(expandSheet ? 0.8 : 1)
        .overlay {
            if let selectedItem, expandSheet {
                ItemView(expandSheet: $expandSheet, animation: animation, item: selectedItem)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        .onChange(of: expandSheet) {
            DispatchQueue.main.asyncAfter(deadline: .now() + (expandSheet ? 0.04 : 0.03)) {
                withAnimation(.smooth(duration: 0.3)) {
                    blurBackground = expandSheet
                }
            }
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
    
    func itemView(item: Item) -> some View {
        ZStack {
            if expandSheet {
                Rectangle()
                    .fill(.clear)
            } else {
                Rectangle()
                    .fill(.background)
                    .overlay {
                        ItemCellView(expandSheet: $expandSheet, animation: animation, item: item)
                            .onTapGesture {
                                withAnimation(.smooth(duration: 0.3)) {
                                    selectedItem = item
                                    expandSheet = true
                                }
                            }
                    }
                    .matchedGeometryEffect(id: item.id + "BGVIEW", in: animation)
            }
        }
        .frame(height: 245)
    }
}

#Preview {
    ContentView()
}
