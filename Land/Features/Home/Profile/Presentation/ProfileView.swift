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
            VStack(alignment: .leading, spacing: 18) {
                header
                
                Button("share your Land link") {
                    
                }
                .font(.standard(.callout))
                .buttonStyle(.white)
                
            }
            .safeAreaPadding(.top, 36)
            .safeAreaPadding(.horizontal, 24)
            .safeAreaPadding(.bottom, 24)
                
                
            VStack(alignment: .leading, spacing: 8) {
                LazyVGrid(columns: [.init(), .init()]) {
                    /*ForEach(viewModel.state.books) { book in
                        let book = Book(name: String(Int.random(in: 1...100)), items: [])
                        bookView(book)
                    }*/
                    
                    ForEach(1...10, id: \.self) { book in
                        let book = Book(name: String(Int.random(in: 1...100)), items: [])
                        bookView(book)
                    }
                }
                .safeAreaPadding(8)
                .safeAreaPadding(.bottom, 24)
            }
            .background {
                Color.white
                    .ignoresSafeArea()
                    .padding(.bottom, -1000)
            }
        }
        .background {
            Color.custom(hex: LocalStorage.userProfile?.profileColor ?? "#F2F2F2")
                .ignoresSafeArea(edges: [.top, .leading, .trailing])
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            let profileColor = Color.custom(hex: LocalStorage.userProfile?.profileColor ?? "#F2F2F2")
            
            HStack {
                Button("back", systemImage: "chevron.left") {
                    
                }
                .labelStyle(.iconOnly)
                .imageScale(.large)
                
                Text("@" + (LocalStorage.userProfile?.username ?? "username"))
                    .font(.standard(.callout, weight: .regular))
                    .frame(maxWidth: .infinity)
                
                Button("more", systemImage: "ellipsis") {
                    
                }
                .labelStyle(.iconOnly)
                .imageScale(.large)
            }
            .foregroundStyle(profileColor.textColor())
            .safeAreaPadding(.horizontal, 24)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity)
            .background {
                profileColor
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            print("sad appear")
            viewModel.trigger(.onAppear)
        }
    }
    
    @ViewBuilder
    var header: some View {
        let profileColor = Color.custom(hex: LocalStorage.userProfile?.profileColor ?? "#F2F2F2")
        
        VStack(alignment: .leading, spacing: 18) {
            if let imageData = LocalStorage.userProfile?.imageData {
                Image(uiImage: UIImage(data: imageData) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 92, height: 92)
                    .clipShape(.circle)
            } else {
                Circle()
                    .fill(Color(uiColor: .secondarySystemFill))
                    .frame(width: 92, height: 92)
            }
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(LocalStorage.userProfile?.name ?? "Name")
                        .font(.standard(.title3, weight: .regular))
                        .frame(height: .heightForFontSize(size: 24))
                        .kerning(-0.24)
                    
                    if let bio = LocalStorage.userProfile?.bio, !bio.isEmpty {
                        Text(bio)
                            .font(.standard(.callout, weight: .regular))
                            .lineSpacing(UIFont.preferredFont(forTextStyle: .callout).lineHeight * 0.25)
                    }
                    
                    /*Text("@" + (LocalStorage.userProfile?.username ?? "username"))
                        .font(.standard(.callout, weight: .regular))
                        .frame(height: .heightForFontSize(size: 14))
                        .kerning(-0.14)
                        .opacity(0.4)*/
                }
                Spacer()
            }
            .foregroundStyle(profileColor.textColor())
            
            /*HStack(spacing: 15) {
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
            }*/
        }
    }
    
    @ViewBuilder
    func bookView(_ book: Book) -> some View {
        Button {
            viewModel.trigger(.onBookTap(book))
        } label: {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.custom(hex: "f2f2f2"))
                .aspectRatio(1.0, contentMode: .fit)
                .overlay {
                    if let image = book.firstImage() {
                        GeometryReader {
                            let size = $0.size
                            
                            Image(uiImage: UIImage(data: image.imageData) ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .blur(radius: 5)
                                .clipShape(.rect(cornerRadius: 24))
                        }
                    }
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
                    .foregroundStyle(book.firstImage() == nil ? .black : .white)
                }
        }
    }
}

#Preview {
    // generate a sample bio
    let user = User(id: UUID().uuidString, username: "johndoe", name: "John Doe", instagramUsername: nil, twitterUsername: nil, websiteUrl: nil, location: "", bio: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", imageData: nil, profileColor: "#2B00FF")
    
    ProfileView(viewModel: ProfileViewModel())
        .onAppear {
            LocalStorage.userProfile = user
        }
}
