//
//  AddTextViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import Dependencies
import Foundation

class AddTextViewModel: ObservableObject {
    
    @Dependency(\.homeRouter) private var router
    
    @Published var state = ViewState()
    
    func trigger(_ action: Action) {
        switch action {
        case .onPop:
            handleOnPop()
            
        case .onNext:
            handleOnNext()
        }
    }
}

extension AddTextViewModel {
    struct ViewState {
        var text = ""
    }
    
    enum Action {
        case onPop
        case onNext
    }
}

private extension AddTextViewModel {
    func handleOnPop() {
        router.pop()
    }
    
    func handleOnNext() {
        router.push(to: .addEntryView(AddEntryViewModel(item: .text(.init(text: state.text)))))
    }
}
