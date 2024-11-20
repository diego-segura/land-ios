//
//  LandApp.swift
//  Land
//
//  Created by Luka Vujnovac on 18.11.2024..
//

import SwiftUI

@main
struct LandApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .overlay(alignment: .bottomTrailing) {
                VStack(spacing: 24) {
                    Button {
                        
                    } label: {
                        Image(systemName: "square")
                            .font(.title2)
                    }
                    .foregroundStyle(.gray)
                    
                    Button {
                        
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
            .preferredColorScheme(.light)
        }
    }
}
