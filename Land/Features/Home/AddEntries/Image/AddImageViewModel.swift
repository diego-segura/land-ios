//
//  AddImageViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 30.11.2024..
//

import Dependencies
import Foundation
import SwiftUI

class AddImageViewModel: ObservableObject {
    
    @Dependency(\.homeRouter) private var router
    @Published var state = ViewState()
    
    func trigger(_ action: Action) {
        switch action {
        case .onStateChange:
            handleOnStateChange()
        case .onPop:
            handleOnPop()
        case .onNext:
            handleOnNext()
        }
    }
    
}

extension AddImageViewModel {
    struct ViewState {
        var selectedItem: Data?
        var canGoNext: Bool = false
    }
    
    enum Action {
        case onPop
        case onNext
        case onStateChange
    }
}

private extension AddImageViewModel {
    func handleOnPop() {
        router.pop()
    }
    
    func handleOnNext() {
        guard let imageItem = state.selectedItem else { return }
        
        let item = ImageGridEntity(
            id: UUID().uuidString,
            title: UUID().uuidString,
            description: UUID().uuidString,
            imageData: imageItem
        )
        router.push(to: .addEntryView(AddEntryViewModel(item: .image(item))))
    }
    
    func handleOnStateChange() {
        state.canGoNext = state.selectedItem != nil
    }
}
