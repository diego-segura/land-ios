//
//  AddTextView.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import SwiftUI

struct AddTextView: View {
    
    @StateObject private var viewModel: AddTextViewModel
    @FocusState private var isFocused: Bool
    
    init(viewModel: @autoclosure @escaping () -> AddTextViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextField(
                "",
                text: $viewModel.state.text,
                prompt: Text("write something").font(.standard(size: 14, weight: 360)).foregroundStyle(Color.custom(hex: "999999")),
                axis: .vertical
            )
            .font(.standard(size: 14, weight: 360))
            .kerning(-0.14)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.sentences)
            .foregroundStyle(Color.custom(hex: "1A1A1A"))
            .tint(.custom(hex: "1A1A1A"))
            .focused($isFocused)
        }
        .padding(.horizontal, 38)
        .padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
}

#Preview {
    NavigationStack {
        AddTextView(viewModel: AddTextViewModel())
    }
}
