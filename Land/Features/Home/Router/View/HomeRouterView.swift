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
    @State private var showFloatingNavigation = true
    
    init(router: @autoclosure @escaping () -> HomeRouter) {
        self._router = StateObject(wrappedValue: router())
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            ProfileView(viewModel: ProfileViewModel())
                .navigationDestination(
                    for: HomePushDestination.self,
                    destination: \.destination
                )
        }
        .tint(.black.opacity(0.5))
        .allowsHitTesting(router.animatedCover == nil)
        .blur(radius: router.animatedCover != nil ? 10 : 0)
        //.scaleEffect(router.animatedCover != nil ? 1.02 : 1)
        //.opacity(router.animatedCover != nil ? 0.5 : 1)
        .overlay {
            ZStack(alignment: .bottom) {
                if let animatedCover = router.animatedCover {
                    Color.white.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture {
                            router.dismiss()
                        }
                    
                    animatedCover.destination
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 5)
                        .fixedSize(horizontal: false, vertical: true)
                        .transition(.blurReplace())
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            if router.animatedCover == nil, showFloatingNavigation {
                floatingNavigation
                    .transition(.blurReplace)
            }
        }
        .animation(.snappy, value: router.animatedCover)
        .animation(.snappy, value: showFloatingNavigation)
        .onChange(of: router.navigationPath) { _, newValue in
            showFloatingNavigation = newValue.last?.showsFloatingNavigation ?? true
        }
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
