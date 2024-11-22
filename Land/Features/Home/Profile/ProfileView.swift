//
//  ProfileView.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import Dependencies
import SwiftUI

struct ProfileView: View {
    
    @Dependency(\.authService) private var authService
    @Dependency(\.homeRouter) private var router
    
    @Environment(\.openURL) private var openUrl
    
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
                    ForEach(items) { item in
                        itemView(item: item)
                    }
                }
                .safeAreaPadding(8)
            }
        }
        .blur(radius: expandSheet ? 3.5 : 0)
        .opacity(expandSheet ? 0.8 : 1)
        .overlay {
            if let selectedItem, expandSheet {
                ItemView(expandSheet: $expandSheet, animation: animation, item: selectedItem)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        .onShake {
            authService.logOut()
        }
    }
    
    var header: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(LocalStorage.userProfile?.name ?? "Name")
                        .font(.standard(size: 24, weight: 310))
                        .frame(height: .heightForFontSize(size: 24))
                        .kerning(-0.24)
                    Text(LocalStorage.userProfile?.username ?? "username")
                        .font(.standard(size: 14, weight: 420))
                        .frame(height: .heightForFontSize(size: 14))
                        .kerning(-0.14)
                        .opacity(0.4)
                }
                Spacer()
                
                if let imageData = LocalStorage.userProfile?.imageData {
                    Image(uiImage: UIImage(data: imageData) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 92, height: 92)
                        .clipShape(.circle)
                }
            }
            
            if let bio = LocalStorage.userProfile?.bio {
                Text(bio)
                    .font(.standard(size: 14, weight: 360))
                    .kerning(-0.14)
                    .foregroundStyle(Color.custom(hex: "666666"))
                    .padding(.trailing, 16)
            }
            
            HStack(spacing: 15) {
                if let websiteUrl = URL(string: LocalStorage.userProfile?.websiteUrl ?? "") {
                    Button {
                        openUrl(websiteUrl)
                    } label: {
                        Image(systemName: "link")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                    }
                }
                if let instagramUrl = URL(string: "https://instagram.com/" + (LocalStorage.userProfile?.instagramUsername ?? "")) {
                    Button {
                        openUrl(instagramUrl)
                    } label: {
                        Image(.instagram)
                    }
                }
                if let twitterUrl = URL(string: "https://twitter.com/" + (LocalStorage.userProfile?.instagramUsername ?? "")) {
                    Button {
                        openUrl(twitterUrl)
                    } label: {
                        Image(.twitter)
                    }
                }
            }
        }
    }
    
    func itemView(item: Item) -> some View {
        ZStack {
            if expandSheet {
                GeometryReader {
                    let size = $0.size
                    
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(.rect(cornerRadius: 24))
                }
                .transition(.blurReplace)
                .opacity(item.id == selectedItem?.id ? 0 : 1)
            } else {
                ItemCellView(expandSheet: $expandSheet, animation: animation, item: item)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.3)) {
                            selectedItem = item
                            expandSheet = true
                        }
                    }
                    .matchedGeometryEffect(id: item.id + "BGVIEW", in: animation)
            }
        }
        .frame(height: 245)
    }
}

#Preview {
    ProfileView()
}
