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
    @Published var state = ViewState()
    
    func trigger(_ action: Action) {
        switch action {
        case .onAppear:
            handleOnAppear()
            
        case .onDisappear:
            handleOnDisappear()
            
        case .onPop:
            handleOnPop()
        }
    }
}

extension BookViewModel {
    struct ViewState {
        var items: [[Item]] = sampleImages.splitByCondition({ _, index in
            index % 2 == 0
        })
        var expandSheet = false
        var selectedItem: Item?
    }
    
    enum Action {
        case onAppear
        case onDisappear
        case onPop
    }
}

private extension BookViewModel {
    func handleOnAppear() {
        AppState.shared.swipeEnabled = true
    }
    
    func handleOnDisappear() {
        AppState.shared.swipeEnabled = false
    }
    
    func handleOnPop() {
        router.pop()
    }
}
