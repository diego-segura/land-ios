//
//  AuthView.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

struct AuthView: View {
    
    @State private var animate = false
    @StateObject private var viewModel: AuthViewModel
    
    init(viewModel: @autoclosure @escaping () -> AuthViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 75) {
                Image(.logoGreen)
                    .offset(y: 6.5)
                    .ignoresSafeArea()
                
                if animate {
                    VStack(spacing: 8) {
                        Button("Continue with Apple", systemImage: "apple.logo") {
                            viewModel.trigger(.onAppleAuth)
                        }
                        .buttonStyle(.dark)
                        Button("Use a phone number") {
                            viewModel.trigger(.onPhoneAuth)
                        }
                        .buttonStyle(.dark)
                        
//                        HStack(spacing: 0) {
//                            Text("or, ")
//                            
//                            Button {
//                                viewModel.trigger(.onSkipAuth)
//                            } label: {
//                                Text("start exploring")
//                                    .contentShape(.rect)
//                                    .underline()
//                            }
//                        }
//                        .font(.standard(size: 16, weight: 360))
//                        .foregroundStyle(Color.brandDark)
//                        .kerning(-0.32)
                    }
                    .padding(.horizontal, 62)
                    .transition(.move(edge: .bottom))
                    .clipped()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .offset(y: animate ? -36 : 0)
            
            if animate {
                Image(.logoTextGreen)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                    .offset(y: -36)
                    .transition(.blurReplace)
            }
        }
        .background(Color.brand)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.smooth) {
                    animate = true
                }
            }
        }
    }
}

#Preview {
    AuthView(viewModel: AuthViewModel())
}
