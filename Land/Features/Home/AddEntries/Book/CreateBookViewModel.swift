//
//  CreateBookViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 30.11.2024..
//

import Dependencies
import Foundation

class CreateBookViewModel: ObservableObject {
    
    @Dependency(\.homeRouter) private var router
    @Published var state: ViewState
    
    init(item: GridItem) {
        self.state = ViewState(item: item)
    }
    
    func trigger(_ action: Action) {
        switch action {
        case .onNext:
            handleOnNext()
            
        case .onPop:
            handleOnPop()
        }
    }
}

extension CreateBookViewModel {
    struct ViewState {
        var bookName = ""
        let item: GridItem
    }
    enum Action {
        case onNext
        case onPop
    }
}

private extension CreateBookViewModel {
    func handleOnNext() {
        let book = Book(name: state.bookName, items: [state.item])
        LocalStorage.books.append(book)
        router.popToRoot()
    }
    
    func handleOnPop() {
        router.pop()
    }
}
