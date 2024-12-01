//
//  AddCaptionView.swift
//  Land
//
//  Created by Luka Vujnovac on 01.12.2024..
//

import SwiftUI

struct AddCaptionView: View {
    
    @StateObject private var viewModel: AddCaptionViewModel
    @FocusState private var isFocused: Bool
    
    init(viewModel: @autoclosure @escaping () -> AddCaptionViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack(spacing: 15) {
            ElementView(element: viewModel.state.item)
            
            HStack(spacing: 2) {
                Text(LocalStorage.userProfile?.username ?? "")
                    .font(.standard(size: 16, weight: 480))
                    .underline()
                
                TextField(
                    "",
                    text: $viewModel.state.caption,
                    prompt: Text("type your caption here").font(.standard(size: 16,weight: 360)).foregroundStyle(.black)
                )
                .tint(.black)
                .focused($isFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            }
        }
        .padding(.horizontal, 10)
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            Button {
                viewModel.trigger(.onNext)
            } label: {
                Text("next")
                    .font(.standard(size: 14, weight: 360))
                    .kerning(-0.14)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundStyle(.black)
            }
            .contentShape(.rect)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding([.bottom, .trailing], 10)
        }
        .customBackButton {
            viewModel.trigger(.onPop)
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    AddCaptionView(
        viewModel: AddCaptionViewModel(
            item: .text(
                .init(
                    id: "some",
                    text: "hello",
                    timeStamp: Date(),
                    description: ""
                )
            ), onComplete: { _ in }
        )
    )
}

#Preview {
    AddCaptionView(
        viewModel: AddCaptionViewModel(
            item: .image(
                .init(
                    id: "some",
                    title: "type",
                    imageData: Data(),
                    timeStamp: Date()
                )
            ), onComplete: { _ in }
        )
    )
}

private struct ElementView: View {
    
    let element: GridItem
    
    var body: some View {
        switch element {
        case .image(let image):
            Image(uiImage: UIImage(data: image.imageData) ?? UIImage())
                .resizable()
                .scaledToFit()
                .clipShape(.rect(cornerRadius: 24))
            
        case .text(let text):
            textView(text)
            
        case .link:
            EmptyView()
        }
    }
    
    func textView(_ element: TextGridItem) -> some View {
        Text(element.text)
            .font(.standard(size: 14, weight: 360))
            .foregroundStyle(Color.custom(hex: "1A1A1A"))
            .allowsTightening(false)
            .fixedSize(horizontal: false, vertical: true)
            .opacity(0.8)
            .lineSpacing(3)
            .padding(.horizontal, 45)
            .padding(.vertical, 36)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .strokeBorder(Color.custom(hex: "d9d9d9"), lineWidth: 1)
            }
            .padding(.horizontal, 42)
    }
}
