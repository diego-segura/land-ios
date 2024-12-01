//
//  WhiteButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import SwiftUI

struct WhiteButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 20)
            .padding(.horizontal, 23)
            .frame(maxWidth: .infinity)
            .background(.white, in: .rect(cornerRadius: 20))
            .opacity(configuration.isPressed ? 0.6 : 1)
            .opacity(isEnabled ? 1 : 0.6)
            .animation(.none, value: configuration.isPressed)
            .shadow(color: .black.opacity(0.05), radius: 25, x: 0, y: 0)
    }
}

extension ButtonStyle where Self == WhiteButtonStyle {
    static var white: Self {
        WhiteButtonStyle()
    }
}

#Preview {
    HStack {
        Button("Hello, World!") {}
            .buttonStyle(.white)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.ultraThinMaterial)
}
