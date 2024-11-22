//
//  BigHighlightedButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

struct BigHighlightedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.light)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .padding(.leading, 23)
            .padding(.trailing, 19)
            .background(Color.brand, in: .rect(cornerRadius: 24))
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == BigHighlightedButtonStyle {
    static var bigHighlighted: Self {
        BigHighlightedButtonStyle()
    }
}

#Preview {
    HStack {
        Button {
            
        } label: {
            HStack {
                Text("next")
                    .font(.standard(size: 16, weight: 360))
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 16))
            }
            .foregroundStyle(.brandDark)
        }
        .buttonStyle(.bigHighlighted)
    }
    .padding()
}
