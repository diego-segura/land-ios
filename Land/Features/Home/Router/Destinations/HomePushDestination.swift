//
//  HomePushDestination.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

enum HomePushDestination: PushDestination {
    case profile
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .profile:
            ProfileView()
        }
    }
}

extension HomePushDestination {
    public var id: String {
        String(describing: self)
    }
    
    static func == (lhs: HomePushDestination, rhs: HomePushDestination) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
