//
//  DarkButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17))
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .allowsTightening(true)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(.black, in: .capsule)
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == DarkButtonStyle {
    static var dark: Self {
        DarkButtonStyle()
    }
}

#Preview {
    @Previewable @State var height: CGFloat = 0.0
    Button("Continue with Apple \(height)", systemImage: "apple.logo") {
        
    }
    .buttonStyle(.dark)
    .background {
        GeometryReader { proxy in
            Color.clear
                .onAppear {
                    height = proxy.size.height
                }
        }
    }
    .padding(.horizontal, 62)
}
