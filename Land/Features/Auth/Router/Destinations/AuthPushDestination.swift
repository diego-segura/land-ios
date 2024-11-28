//
//  AuthPushDestination.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

enum AuthPushDestination: PushDestination {
    case register
    case welcome
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .register:
            CreateProfileView(viewModel: CreateProfileViewModel())
            
        case .welcome:
            WelcomeView()
        }
    }
}

extension AuthPushDestination {
    public var id: String {
        String(describing: self)
    }
    
    static func == (lhs: AuthPushDestination, rhs: AuthPushDestination) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
