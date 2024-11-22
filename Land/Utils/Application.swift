//
//  Application.swift
//  YPages
//
//  Created by Luka Vujnovac on 27.07.2024..
//

import Foundation

enum Application {
    case development
    case production
    
    static var environment: Application {
        #if DEVELOPMENT
        .development
        #else
        .production
        #endif
    }
    
    static var isRunningTests: Bool {
        NSClassFromString("XCTestCase") != nil
    }
    
    static var region: String? {
        Locale.current.language.region?.identifier
    }
    
    static var version: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
