//
//  HomeRouterView.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies
import SwiftUI

struct HomeRouterView: View {
    
    @StateObject private var router: HomeRouter
    
    @State private var showAnimatedCover = true
    
    init(router: @autoclosure @escaping () -> HomeRouter) {
        self._router = StateObject(wrappedValue: router())
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            ProfileView(viewModel: ProfileViewModel())
                .navigationDestination(for: HomePushDestination.self) {
                    $0.destination
                }
        }
        .allowsHitTesting(router.animatedCover == nil)
        .blur(radius: router.animatedCover != nil ? 10 : 0)
        .overlay {
            if let animatedCover = router.animatedCover {
                animatedCover.destination
                    .transition(.blurReplace())
                    .onTapGesture {
                        router.dismiss()
                    }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if router.animatedCover == nil {
                floatingNavigation
                    .transition(.blurReplace)
            }
        }
        .animation(.smooth(duration: 0.3), value: router.animatedCover)
    }
    
    private var floatingNavigation: some View {
        VStack(spacing: 24) {
            Button {
                
            } label: {
                Image(systemName: "square")
                    .font(.title2)
            }
            .foregroundStyle(.gray)
            
            Button {
                router.present(.addEntriesMenu, as: .animated)
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
            }
            .foregroundStyle(.gray)
            
            Button {
                
            } label: {
                Image(systemName: "circle.fill")
                    .font(.title2)
                    .foregroundStyle(.gray.secondary)
            }
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 22)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .strokeBorder(Color.gray.secondary, lineWidth: 1)
                .shadow(color: .black.opacity(0.1), radius: 25, x: 0, y: 0)
        }
        .padding(.trailing, 22)
    }
}

#Preview {
    HomeRouterView(router: HomeRouter())
}
