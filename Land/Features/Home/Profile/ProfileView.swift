//
//  ProfileView.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import Dependencies
import SwiftUI

struct ProfileView: View {
    
    @Environment(\.openURL) private var openUrl
    @Namespace private var animation
    
    @StateObject private var viewModel: ProfileViewModel
    
    init(viewModel: @autoclosure @escaping () -> ProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 30) {
                    header
                        .padding(.horizontal, 32)
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Text("edit profile")
                                .font(.standard(size: 14, weight: 360))
                                .foregroundStyle(.black)
                        }
                        .buttonStyle(.standard)
                        
                        Button {
                            
                        } label: {
                            Text("copy your link")
                                .font(.standard(size: 14, weight: 360))
                                .foregroundStyle(.black)
                        }
                        .buttonStyle(.highlighted)
                    }
                    .padding(.horizontal, 16)
                }
                Divider()
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
//                    ForEach(viewModel.state.items) { item in
//                        itemView(item: item)
//                    }
                    GeometryReader { proxy in
                        let size = proxy.size.width
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.custom(hex: "f2f2f2"))
                            .frame(width: size, height: size)
                    }
                    GeometryReader { proxy in
                        let size = proxy.size.width
                        Button {
                            viewModel.trigger(.onBookTap)
                        } label: {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color.custom(hex: "f2f2f2"))
                                .frame(width: size, height: size)
                                .overlay {
                                    VStack(spacing: 0) {
                                        Text("Camera roll")
                                            .font(.standard(size: 16, weight: 420))
                                            .frame(height: .heightForFontSize(size: 20))
                                        Text("9 entries")
                                            .font(.standard(size: 12, weight: 360))
                                            .kerning(-0.12)
                                            .frame(height: .heightForFontSize(size: 20))
                                            .opacity(0.6)
                                    }
                                    .foregroundStyle(.black)
                                }
                        }
                    }
                }
                .safeAreaPadding(8)
            }
        }
        .blur(radius: viewModel.state.expandSheet ? 3.5 : 0)
        .opacity(viewModel.state.expandSheet ? 0.8 : 1)
        .overlay {
            if let selectedItem = viewModel.state.selectedItem, viewModel.state.expandSheet {
                ItemView(expandSheet: $viewModel.state.expandSheet, animation: animation, item: selectedItem)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
        .onShake {
            viewModel.trigger(.onLogOut)
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
                    Text("@" + (LocalStorage.userProfile?.username ?? "username"))
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
            if viewModel.state.expandSheet {
                GeometryReader {
                    let size = $0.size
                    
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(.rect(cornerRadius: 24))
                }
                .transition(.blurReplace)
                .opacity(item.id == viewModel.state.selectedItem?.id ? 0 : 1)
            } else {
                ItemCellView(expandSheet: $viewModel.state.expandSheet, animation: animation, item: item)
                    .onTapGesture {
                        withAnimation(.smooth(duration: 0.3)) {
                            viewModel.state.selectedItem = item
                            viewModel.state.expandSheet = true
                        }
                    }
                    .matchedGeometryEffect(id: item.id + "BGVIEW", in: animation)
            }
        }
        .frame(height: 245)
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
