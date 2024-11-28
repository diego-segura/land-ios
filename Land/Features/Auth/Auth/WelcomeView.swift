//
//  WelcomeView.swift
//  Land
//
//  Created by Luka Vujnovac on 27.11.2024..
//

import Dependencies
import SwiftUI

struct WelcomeView: View {
    
    @Dependency(\.authRouter) private var authRouter
    
    @State private var showImage = false
    @State private var showName = false
    @State private var showText = false
    
    let image: UIImage?
    
    init() {
        self.image = UIImage(data: LocalStorage.userProfile?.imageData ?? Data())
    }
    
    var body: some View {
        VStack(spacing: 25) {
            if showImage {
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 92, height: 92)
                            .clipShape(.circle)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.smooth(duration: 0.5)) {
                                        showName = true
                                    }
                                }
                            }
                    }
            }
            
            if showName {
                HStack(spacing: 0) {
                    Text(name)
                        .transition(.blurReplace)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.smooth(duration: 0.5)) {
                                    showText = true
                                }
                            }
                        }
                    if showText {
                        Text(title)
                            .transition(.blurReplace)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.smooth(duration: 0.35)) {
                    showImage = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                authRouter.switch(to: .home)
            }
        }
    }
    
    var title: AttributedString {
        var title = AttributedString(showText ? ", this is your profile" : "")
        title.font = .standard(size: 24, weight: 310)
        title.foregroundColor = .custom(hex: "999999")
        return title
    }
    
    var name: AttributedString {
        var name = AttributedString(LocalStorage.userProfile?.username ?? "user")
        name.font = .standard(size: 24, weight: 310)
        name.foregroundColor = .black
        return name
    }
}

#Preview {
    WelcomeView()
}
