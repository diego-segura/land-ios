//
//  AddEntryViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 29.11.2024..
//

import Dependencies
import Foundation

class AddEntryViewModel: ObservableObject {
 
    @Dependency(\.homeRouter) private var router
    
    @Published var state: ViewState
    
    init(item: GridItem) {
        self.state = ViewState(gridItem: item, books: LocalStorage.books)
    }
    
    func trigger(_ action: Action) {
        switch action {
        case .onPop:
            handleOnPop()
        case .onAddCaptions:
            handleOnAddCaptions()
        case .onBookSelected(let book):
            handleOnBookSelected(book)
        case .onAddBook:
            handleOnAddBook()
        }
    }
}

extension AddEntryViewModel {
    struct ViewState {
        let gridItem: GridItem
        var books: [Book]
    }
    
    enum Action {
        case onPop
        case onAddCaptions
        case onBookSelected(Book)
        case onAddBook
    }
}

private extension AddEntryViewModel {
    func handleOnPop() {
        router.pop()
    }
    func handleOnAddCaptions() {
        // TODO: navigate to add captions
    }
    func handleOnBookSelected(_ book: Book) {
        var tappedBook = LocalStorage.books.first(where: { $0.id == book.id })
        tappedBook?.items.append(state.gridItem)

        if let tappedBook {
            LocalStorage.books.removeAll(where: { $0.id == tappedBook.id })
            LocalStorage.books.append(tappedBook)
            router.popToRoot()
        }
    }
    func handleOnAddBook() {
        // TODO: create a book and save entry
    }
}
