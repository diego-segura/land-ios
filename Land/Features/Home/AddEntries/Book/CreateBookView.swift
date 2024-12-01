//
//  CreateBookView.swift
//  Land
//
//  Created by Luka Vujnovac on 29.11.2024..
//

import SwiftUI

struct CreateBookView: View {
    
    @StateObject private var viewModel: CreateBookViewModel
    @FocusState private var isFocused: Bool
    
    init(viewModel: @autoclosure @escaping () -> CreateBookViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack(spacing: 43) {
            VStack(spacing: 16){
                Text("create a new book")
                    .font(.standard(size: 14, weight: 420))
                    .kerning(-0.14)
                
                gridItem(viewModel.state.item)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("book name")
                    .font(.standard(size: 14, weight: 310))
                    .foregroundStyle(.black)
                    .kerning(-0.28)
                
                TextField(
                    "",
                    text: $viewModel.state.bookName,
                    prompt: Text("type something here").foregroundStyle(.black.opacity(0.3)),
                    axis: .vertical
                )
                .kerning(-0.28)
                .font(.standard(size: 14, weight: 310))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .tint(.black)
                .focused($isFocused)
            }
            .padding(.horizontal, 85)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            Button {
                viewModel.trigger(.onNext)
            } label: {
                HStack {
                    Text("next")
                        .font(.standard(size: 16, weight: 360))
                        .foregroundStyle(.brandDark)
                        .kerning(-0.14)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16))
                        .foregroundStyle(.brandDark)
                }
                .padding(.vertical, 8)
                .padding(.leading, 23)
                .padding(.trailing, 19)
            }
            .buttonStyle(.highlighted)
            .clipShape(.rect(cornerRadius: 24))
            .padding(.horizontal, 10)
            .padding(.bottom, 13)
        }
        .customBackButton {
            viewModel.trigger(.onPop)
        }
        .onAppear {
            isFocused = true
        }
    }
    
    @ViewBuilder
    func gridItem(_ item: GridItem) -> some View {
        switch item {
        case .image(let image):
            if let image = UIImage(data: image.imageData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 145, height: 145)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 24))
                    .shadow(color: .black.opacity(0.1), radius: 25, x: 0, y: 0)
            }
            
        case .text:
            Image(systemName: "book.pages")
                .font(.system(size: 38))
                .font(.standard(size: 12, weight: 360))
                .foregroundStyle(Color.custom(hex: "1a1a1a"))
                .opacity(0.8)
                .frame(width: 145, height: 145)
                .background(Color.custom(hex: "f2f2f2"), in: .rect(cornerRadius: 24))
            
        case .link:
            EmptyView()
        }
    }
}

#Preview {
    CreateBookView(
        viewModel: CreateBookViewModel(
            item: .text(
                .init(
                    id: UUID().uuidString,
                    text: "dalmacijo moja suzo procvala",
                    timeStamp: Date(),
                    description: ""
                )
            )
        )
    )
}

#Preview("image"){
    CreateBookView(
        viewModel: CreateBookViewModel(
            item: .image(
                .init(
                    id: "some",
                    title: "",
                    imageData: Data(),
                    timeStamp: Date()
                )
            )
        )
    )
}
