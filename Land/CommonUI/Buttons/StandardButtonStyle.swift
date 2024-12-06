//
//  StandardButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 18.11.2024..
//

import SwiftUI

struct StandardButtonStyle<S1: ShapeStyle, S2: ShapeStyle>: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    var background: S1
    var foreground: S2
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(background, in: .rect(cornerRadius: 6, style: .continuous))
            .opacity(configuration.isPressed ? 0.6 : 1)
            .animation(.none, value: configuration.isPressed)
            .opacity(isEnabled ? 1 : 0.6)
    }
}

extension ButtonStyle where Self == StandardButtonStyle<Color, Color> {
    static var highlighted: Self {
        StandardButtonStyle(background: Color.brand, foreground: Color.brandDark)
    }
    
    static var standard: Self {
        StandardButtonStyle(background: Color(uiColor: .tertiarySystemFill), foreground: Color(uiColor: .label))
    }
    
    static var white: Self {
        StandardButtonStyle(background: Color.white, foreground: Color(uiColor: .label))
    }
}

#Preview {
    VStack {
        GroupBox("Enabled") {
            HStack {
                Button("Button") {}
                    .buttonStyle(.standard)
                Button("Button") {}
                    .buttonStyle(.white)
                Button("Button") {}
                    .buttonStyle(.highlighted)
            }
        }
        
        GroupBox("Disabled") {
            HStack {
                Button("Button") {}
                    .buttonStyle(.standard)
                Button("Button") {}
                    .buttonStyle(.white)
                Button("Button") {}
                    .buttonStyle(.highlighted)
            }
        }
        .disabled(true)
    }
    .padding()
}
