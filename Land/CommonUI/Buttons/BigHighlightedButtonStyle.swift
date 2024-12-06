//
//  BigHighlightedButtonStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

struct BigHighlightedButtonStyle<S1: ShapeStyle, S2: ShapeStyle>: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    var background: S1
    var foreground: S2
    
    init(_ background: S1, _ foreground: S2) {
        self.background = background
        self.foreground = foreground
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(ExtendedLabelStyle())
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 25)
            .foregroundStyle(foreground)
            .background(background, in: .rect(cornerRadius: 20, style: .continuous))
            .opacity(configuration.isPressed ? 0.6 : 1)
            .opacity(isEnabled ? 1 : 0.6)
    }
}

extension ButtonStyle where Self == BigHighlightedButtonStyle<Color, Color> {
    static var bigStandard: Self {
        BigHighlightedButtonStyle(Color(uiColor: .tertiarySystemFill), Color(uiColor: .label))
    }
    
    static var bigWhite: Self {
        BigHighlightedButtonStyle(Color.white, Color(uiColor: .label))
    }
    
    static var bigHighlighted: Self {
        BigHighlightedButtonStyle(Color.brand, Color.brandDark)
    }
}

#Preview {
    VStack {
        GroupBox("Enabled") {
            Button {
                
            } label: {
                Label("next", systemImage: "arrow.right")
                    .font(.standard(weight: .regular))
            }
            .buttonStyle(.bigHighlighted)
            
            Button {
                
            } label: {
                Label("next", systemImage: "arrow.right")
                    .font(.standard(weight: .regular))
            }
            .buttonStyle(.bigStandard)
            
            Button {
                
            } label: {
                Label("next", systemImage: "arrow.right")
                    .font(.standard(weight: .regular))
            }
            .buttonStyle(.bigWhite)
            .shadow(radius: 10)
        }
        
        GroupBox("Disabled") {
            Button {
                
            } label: {
                Label("next", systemImage: "arrow.right")
                    .font(.standard(weight: .regular))
            }
            .buttonStyle(.bigHighlighted)
            
            Button {
                
            } label: {
                Label("next", systemImage: "arrow.right")
                    .font(.standard(weight: .regular))
            }
            .buttonStyle(.bigStandard)
            
            Button {
                
            } label: {
                Label("next", systemImage: "arrow.right")
                    .font(.standard(weight: .regular))
            }
            .buttonStyle(.bigWhite)
        }
        .disabled(true)
    }
    .padding()
}
