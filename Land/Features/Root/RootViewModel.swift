//
//  RootViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies
import Foundation

class RootViewModel: ObservableObject {
    
    @Dependency(\.authRouter) private var authRouter
    
    @Published private(set) var state = ViewState()
    
    func trigger(_ action: Action) {
        switch action {
        case .onViewAppear:
            handleViewAppear()
            
        case .onUpdateState(let rootState):
            state.rootState = rootState
        }
    }
}

extension RootViewModel {
    enum Action {
        case onViewAppear
        case onUpdateState(ViewState.RootState)
    }
    
    struct ViewState {
        enum RootState {
            case loading
            case auth
            case home
        }
        
        var rootState: RootState = LocalStorage.isLoggedIn ? .home : .auth
    }
}

private extension RootViewModel {
    func handleViewAppear() {
        if LocalStorage.isLoggedIn {
            state.rootState = .home
        } else {
            state.rootState = .auth
        }
    }
}
