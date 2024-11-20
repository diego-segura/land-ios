//
//  HighlightedButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 18.11.2024..
//

import SwiftUI

struct HighlightedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.callout)
            .fontWeight(.light)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#E0FF00"), in: .rect(cornerRadius: 6))
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == HighlightedButtonStyle {
    static var highlighted: Self {
        HighlightedButtonStyle()
    }
}

#Preview {
    HStack {
        Button("Hello, World!") {}
            .buttonStyle(.highlighted)
        Button("Hello, World!") {}
            .buttonStyle(.standard)
    }
    .padding()
}

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}
