//
//  LocalStorage.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

enum LocalStorage {
    @Storage(key: "IS_LOGGED_IN", defaultValue: false)
    static var isLoggedIn: Bool
    
    @Storage(key: "USER_PROFILE", defaultValue: nil)
    static var userProfile: User?
}
