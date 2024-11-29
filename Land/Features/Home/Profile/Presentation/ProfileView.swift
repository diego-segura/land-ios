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
                LazyVGrid(columns: [.init(), .init()]) {
                    ForEach(viewModel.state.books) { book in
                        bookView(book)
                    }
                }
                .safeAreaPadding(8)
            }
        }
        .onAppear {
            print("sad appear")
            viewModel.trigger(.onAppear)
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
            
            if let bio = LocalStorage.userProfile?.bio, !bio.isEmpty {
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
    
    func bookView(_ book: Book) -> some View {
        GeometryReader { proxy in
            let size = proxy.size.width
            Button {
                viewModel.trigger(.onBookTap(book))
            } label: {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.custom(hex: "f2f2f2"))
                    .overlay {
                        VStack(spacing: 0) {
                            Text(book.name)
                                .font(.standard(size: 16, weight: 420))
                                .frame(height: .heightForFontSize(size: 20))
                            Text("\(book.items.count) entries")
                                .font(.standard(size: 12, weight: 360))
                                .kerning(-0.12)
                                .frame(height: .heightForFontSize(size: 20))
                                .opacity(0.6)
                        }
                        .foregroundStyle(.black)
                    }
            }
            .frame(width: size, height: size)
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel())
}
