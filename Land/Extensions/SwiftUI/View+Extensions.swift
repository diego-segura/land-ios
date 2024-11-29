//
//  View+Extensions.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

extension View {
    
    var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
                .opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    var noteAnimation: Animation {
        .smooth(duration: 0.3, extraBounce: 0)
    }
    
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            
            return 0
        }
        
        return 0
    }
    
    func customBackButton(action: @escaping () -> Void) -> some View {
        self
            .navigationBarBackButtonHidden()
            .safeAreaInset(edge: .top) {
                HStack(spacing: 2) {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16))
                        Text("back")
                            .font(.standard(size: 16, weight: 360))
                    }
                    .contentShape(.rect)
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                .foregroundStyle(.black)
                .opacity(0.5)
                .padding(.leading, 23)
                .padding(.top, 25)
            }
    }
}
