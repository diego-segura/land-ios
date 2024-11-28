//
//  AUthViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies
import Foundation

class AuthViewModel: ObservableObject {
    
    @Dependency(\.authRouter) private var router
    @Dependency(\.authService) private var authService
    
    @Published private(set) var state = ViewState()
    
    func trigger(_ action: Action) {
        switch action {
        case .onAppleAuth:
            handleAppleAuth()
            
        case .onPhoneAuth:
            handlePhoneAuth()
            
        case .onSkipAuth:
            handleSkipAuth()
        }
    }
}

extension AuthViewModel {
    enum Action {
        case onAppleAuth
        case onPhoneAuth
        case onSkipAuth
    }
    
    struct ViewState {
        
    }
}

private extension AuthViewModel {
    func handleAppleAuth() {
        router.push(to: .register)
    }
    
    func handlePhoneAuth() {
        router.push(to: .register)
    }
    
    func handleSkipAuth() {
        authService.logIn()
    }
}
