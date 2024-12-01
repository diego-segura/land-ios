//
//  AddCaptionViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 01.12.2024..
//

import Dependencies
import Foundation

class AddCaptionViewModel: ObservableObject {
    
    @Dependency(\.homeRouter) private var router
    @Published var state: ViewState
    
    var onComplete: ((String) -> Void)?
    
    init(item: GridItem, onComplete: @escaping (String) -> Void) {
        self.onComplete = onComplete
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

extension AddCaptionViewModel {
    struct ViewState {
        let item: GridItem
        var caption = ""
    }
    enum Action {
        case onNext
        case onPop
    }
}

private extension AddCaptionViewModel {
    func handleOnNext() {
        onComplete?(state.caption)
        router.pop()
    }
    
    func handleOnPop() {
        router.pop()
    }
}
