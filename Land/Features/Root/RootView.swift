//
//  RootView.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import Dependencies
import SwiftUI

struct RootView: View {
    
    @Dependency(\.authRouter) private var authRouter
    @Dependency(\.homeRouter) private var homeRouter
    
    @StateObject private var viewModel: RootViewModel
    
    init(viewModel: @autoclosure @escaping () -> RootViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        Group {
            switch viewModel.state.rootState {
            case .loading:
                ProgressView()
                
            case .auth:
                auth
                    .transition(.offset(x: -UIScreen.main.bounds.width))
                
            case .home:
                home
                    .transition(.offset(x: UIScreen.main.bounds.width))
            }
        }
        .animation(.smooth, value: viewModel.state.rootState)
        .onAppear {
            viewModel.trigger(.onViewAppear)
        }
    }
}

private extension RootView {
    var auth: some View {
        AuthRouterView(router: authRouter)
            .onReceive(authRouter.onSwitchPublisher) { _ in
                viewModel.trigger(.onUpdateState(.home))
            }
    }
    
    var home: some View {
        HomeRouterView(router: homeRouter)
            .onReceive(homeRouter.onSwitchPublisher) { _ in
                viewModel.trigger(.onUpdateState(.auth))
            }
    }
}

#Preview {
    RootView(viewModel: RootViewModel())
}
