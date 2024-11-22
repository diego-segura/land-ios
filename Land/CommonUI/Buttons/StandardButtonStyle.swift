//
//  StandardButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 18.11.2024..
//

import SwiftUI

struct StandardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.callout)
            .fontWeight(.light)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.gray.tertiary, in: .rect(cornerRadius: 6))
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == StandardButtonStyle {
    static var standard: Self {
        StandardButtonStyle()
    }
}

#Preview {
    HStack {
        Button("Hello, World!") {}
            .buttonStyle(.standard)
        Button("Hello, World!") {}
            .buttonStyle(.standard)
    }
    .padding()
}
