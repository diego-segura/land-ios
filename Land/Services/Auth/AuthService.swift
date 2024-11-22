//
//  AuthService.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies

class AuthService {
    
    @Dependency(\.authRouter) private var authRouter
    @Dependency(\.homeRouter) private var homeRouter
    
    func logIn() {
        LocalStorage.isLoggedIn = true
        authRouter.switch(to: .home)
    }
    
    func logOut() {
        LocalStorage.isLoggedIn = false
        homeRouter.switch(to: .auth)
    }
}
