//
//  WhiteButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import SwiftUI

struct WhiteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 20)
            .padding(.horizontal, 23)
            .frame(maxWidth: .infinity)
            .background(.white, in: .rect(cornerRadius: 20))
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.none, value: configuration.isPressed)
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
