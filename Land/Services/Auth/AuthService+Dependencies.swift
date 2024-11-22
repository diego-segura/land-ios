//
//  AuthService+Dependencies.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies

private enum AuthServiceDependencyKey: DependencyKey {
    static var liveValue: AuthService = AuthService()
}

extension DependencyValues {
    var authService: AuthService {
        get { self[AuthServiceDependencyKey.self] }
        set { self[AuthServiceDependencyKey.self] = newValue }
    }
}
