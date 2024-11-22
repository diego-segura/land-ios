//
//  AuthRouter+Dependencies.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies

private enum AuthRouterDependencyKey: DependencyKey {
    static var liveValue: AuthRouter = AuthRouter()
}

extension DependencyValues {
    var authRouter: AuthRouter {
        get { self[AuthRouterDependencyKey.self] }
        set { self[AuthRouterDependencyKey.self] = newValue }
    }
}
