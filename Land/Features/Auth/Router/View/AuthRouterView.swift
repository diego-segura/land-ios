//
//  AuthRouterView.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies
import SwiftUI

struct AuthRouterView: View {
    
    @StateObject private var router: AuthRouter
    
    init(router: @autoclosure @escaping () -> AuthRouter) {
        self._router = StateObject(wrappedValue: router())
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            WelcomeView(viewModel: WelcomeViewModel())
                .navigationDestination(for: AuthPushDestination.self) { $0.destination }
        }
        .tint(.black)
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}
