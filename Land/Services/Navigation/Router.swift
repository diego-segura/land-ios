//
//  Router.swift
//  YPages
//
//  Created by Luka Vujnovac on 27.07.2024..
//

import Foundation
import Combine

class Router<T: PushDestination, U: SheetDestination, V: SwitchDestination>: ObservableObject {
    typealias PushDestination = T
    typealias SheetDestination = U
    typealias SwitchDestination = V
    
    @Published var navigationPath: [PushDestination]
    @Published var sheet: SheetDestination?
    @Published var fullScreenSheet: SheetDestination?
    @Published var animatedCover: SheetDestination?
    
    let onSwitchPublisher = PassthroughSubject<SwitchDestination, Never>()
    
    init(navigationPath: [PushDestination] = []) {
        self.navigationPath = navigationPath
    }
    
    func push(to pushDestination: PushDestination) {
        guard canPush(to: pushDestination) else { return }
        navigationPath.append(pushDestination)
    }
    
    func present(_ sheet: SheetDestination, as presentOption: PresentOption = .sheet) {
        switch presentOption {
        case .animated:
            self.animatedCover = sheet
        case .fullScreen:
            self.fullScreenSheet = sheet
        case .sheet:
            self.sheet = sheet
        }
    }
    
    func dismiss() {
        animatedCover = nil
        sheet = nil
        fullScreenSheet = nil
    }
    
    func pop() {
        guard canPop() else { return }
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        guard canPop() else { return }
        navigationPath.removeAll()
    }
    
    func `switch`(to switchDestination: SwitchDestination) {
        popToRoot()
        dismiss()
        onSwitchPublisher.send(switchDestination)
    }
}

private extension Router {
    func canPush(to pushDestination: PushDestination) -> Bool {
        return navigationPath.last != pushDestination
    }
    
    func canPop() -> Bool {
        return !navigationPath.isEmpty
    }
}
