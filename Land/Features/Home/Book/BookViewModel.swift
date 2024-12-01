//
//  BookViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import Dependencies
import Foundation

class BookViewModel: ObservableObject {
    
    @Dependency(\.homeRouter) private var router
    @Published var state: ViewState
    
    init(book: Book) {
        self.state = ViewState(book: book)
        state.items = book.items.splitByCondition({ _, index in
            index % 2 == 0
        })
    }
    
    func trigger(_ action: Action) {
        switch action {
        case .onAdd:
            handleOnAdd()
            
        case .onAppear:
            handleOnAppear()
            
        case .onPop:
            handleOnPop()
        }
    }
}

extension BookViewModel {
    struct ViewState {
        var book: Book
        var items: [[GridItem]] = []
        var expandSheet = false
        var selectedItem: GridItem?
        var lastUpdated = ""
    }
    
    enum Action {
        case onAppear
        case onPop
        case onAdd
    }
}

private extension BookViewModel {
    func handleOnAppear() {
        AppState.shared.swipeEnabled = true
        
        if let lastItem = state.book.items.last {
            state.lastUpdated = lastItem.timeStamp.timeAgo()
        }
    }
    
    func handleOnPop() {
        router.pop()
    }
    
    func handleOnAdd() {
        router.present(.addEntriesMenu, as: .animated)
    }
}
