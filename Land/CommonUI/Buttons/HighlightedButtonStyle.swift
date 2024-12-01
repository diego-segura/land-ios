//
//  HighlightedButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 18.11.2024..
//

import SwiftUI

struct HighlightedButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.brand, in: .rect(cornerRadius: 6))
            .opacity(configuration.isPressed ? 0.6 : 1)
            .opacity(isEnabled ? 1 : 0.6)
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
