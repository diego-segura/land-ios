//
//  ProfileViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import Dependencies
import Foundation

class ProfileViewModel: ObservableObject {
    
    @Dependency(\.authService) private var authService
    @Dependency(\.homeRouter) private var router
    
    @Published var state = ViewState()
    
    func trigger(_ action: Action) {
        switch action {
        case .onLogOut:
            handleOnLogOut()
            
        case .onBookTap:
            handleOnBookTap()
        }
    }
    
}

extension ProfileViewModel {
    struct ViewState {
        var expandSheet = false
        var selectedItem: Item?
        let items = gridItems
    }
    
    enum Action {
        case onLogOut
        case onBookTap
    }
}

private extension ProfileViewModel {
    func handleOnLogOut() {
        authService.logOut()
    }
    
    func handleOnBookTap() {
        router.push(to: .book(BookViewModel()))
    }
}
