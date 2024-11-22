//
//  HomeRouter+Dependencies.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies

private enum HomeRouterDependencyKey: DependencyKey {
    static var liveValue: HomeRouter = HomeRouter()
}

extension DependencyValues {
    var homeRouter: HomeRouter {
        get { self[HomeRouterDependencyKey.self] }
        set { self[HomeRouterDependencyKey.self] = newValue }
    }
}
