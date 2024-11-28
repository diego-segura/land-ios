//
//  AddEntriesMenuView.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import SwiftUI

struct AddEntriesMenuView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Spacer()
            Text("add entries")
                .font(.standard(size: 24, weight: 310))
                .padding(.horizontal, 10)
            VStack(spacing: 5) {
                button(title: "from your camera roll", symbol: "camera") {}
                button(title: "add a link", symbol: "link") {}
                button(title: "write some thoughts", symbol: "text.bubble") {}
            }
        }
        .contentShape(.rect)
        .padding(.horizontal, 10)
        .padding(.bottom, 42)
    }
    
    func button(title: String, symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.standard(size: 16, weight: 360))
                Spacer()
                Image(systemName: symbol)
                    .font(.system(size: 16))
            }
            .foregroundStyle(.black)
        }
        .buttonStyle(.white)
    }
}

#Preview {
    @Previewable @State var isPresented = true
    ProfileView(viewModel: ProfileViewModel())
        .overlay(content: {
            Button("tap") {
                withAnimation(.smooth(duration: 0.3)) {
                    isPresented.toggle()
                }
            }
        })
        .overlay(content: {
            if isPresented {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .transition(.blurReplace)
                    .ignoresSafeArea()
            }
        })
        .fullScreenCover(isPresented: $isPresented) {
            AddEntriesMenuView()
                .presentationBackground(.clear)
        }
}
