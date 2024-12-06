//
//  AddEntriesMenuView.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import Dependencies
import SwiftUI

struct AddEntriesMenuView: View {
    
    @Dependency(\.homeRouter) private var router
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Spacer()
            Text("add entries")
                .font(.standard(.title1, weight: .light))
                .padding(.horizontal, 10)
            
            VStack(spacing: 5) {
                button(title: "from your camera roll", symbol: "camera") {
                    router.dismiss()
                    router.push(to: .addImage(AddImageViewModel()))
                }
                button(title: "add a link", symbol: "link") {}
                button(title: "write some thoughts", symbol: "text.bubble") {
                    router.dismiss()
                    router.push(to: .addText(AddTextViewModel()))
                }
            }
        }
        .contentShape(.rect)
        .padding(.horizontal, 10)
        .padding(.bottom, 42)
    }
    
    func button(title: String, symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(title, systemImage: symbol)
        }
        .buttonStyle(.bigWhite)
    }
}

#Preview {
    @Previewable @State var isPresented = true
    NavigationStack {
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
}
