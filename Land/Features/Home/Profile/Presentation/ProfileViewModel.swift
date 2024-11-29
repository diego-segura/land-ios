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
    
    @Published var state: ViewState
    
    init() {
        self.state = .init(books: LocalStorage.books)
    }
    
    func trigger(_ action: Action) {
        switch action {
        case .onLogOut:
            handleOnLogOut()
            
        case .onBookTap(let book):
            handleOnBookTap(book)
            
        case .onAppear:
            handleOnAppear()
        }
    }
    
}

extension ProfileViewModel {
    struct ViewState {
        var books: [Book]
    }
    
    enum Action {
        case onAppear
        case onLogOut
        case onBookTap(Book)
    }
}

private extension ProfileViewModel {
    func handleOnLogOut() {
        authService.logOut()
    }
    
    func handleOnBookTap(_ book: Book) {
        router.push(to: .book(BookViewModel(book: book)))
    }
    
    func handleOnAppear() {
        state.books = LocalStorage.books
    }
}
