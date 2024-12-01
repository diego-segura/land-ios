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
        var gridItem: GridItem
        var itemDescription = ""
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
        let viewModel = AddCaptionViewModel(item: state.gridItem) { [unowned self] caption in
            state.itemDescription = caption
        }
        router.push(to: .addCaption(viewModel))
    }
    
    func handleOnBookSelected(_ book: Book) {
        var tappedBook = LocalStorage.books.first(where: { $0.id == book.id })
        let item = createItem()
        tappedBook?.items.append(item)
        
        if let tappedBook {
            LocalStorage.books.removeAll(where: { $0.id == tappedBook.id })
            LocalStorage.books.append(tappedBook)
            router.popToRoot()
        }
    }
    
    func handleOnAddBook() {
        router.push(to: .createBook(CreateBookViewModel(item: state.gridItem)))
    }
    
    func createItem() -> GridItem {
        switch state.gridItem {
        case .image(let image):
                .image(
                    ImageGridEntity(
                        id: image.id,
                        title: state.itemDescription,
                        imageData: image.imageData,
                        timeStamp: image.timeStamp
                    )
                )
        case .text(let text):
                .text(
                    TextGridItem(
                        id: text.id,
                        text: text.text,
                        timeStamp: text.timeStamp,
                        description: state.itemDescription
                    )
                )
        case .link:
                .link
        }
    }
}
