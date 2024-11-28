//
//  TypingView.swift
//  Land
//
//  Created by Luka Vujnovac on 27.11.2024..
//

import SwiftUI

struct TypingView: View {
    
    @State private var displayedText = ""
    @State private var showLine = false
    
    var fullText : AttributedString
    let typingSpeed = 2.0
    
    var body: some View {
        HStack(spacing: 2) {
            Text(displayedText)
                .font(.standard(size: 24, weight: 310))
                .foregroundStyle(Color.custom(hex: "999999"))
            
            Rectangle()
                .frame(width: 2, height: 24)
                .opacity(showLine ? 1 : 0)
        }
        .foregroundStyle(Color.custom(hex: "999999"))
        .onAppear {
            withAnimation(.smooth(duration: 0.5).repeatForever(autoreverses: false)) {
                showLine.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                startTyping()
            }
        }
    }
    
    func startTyping() {
        displayedText = ""
        for (index,character) in fullText.characters.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + typingSpeed * Double(index)) {
                displayedText.append(character)
                if index == fullText.characters.count - 1 {
                    showLine = false
                } else {
                    showLine.toggle()
                }
            }
        }
    }
}
