//
//  HomePushDestination.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

enum HomePushDestination: PushDestination {
    
    case addEntryView(AddEntryViewModel)
    case addText(AddTextViewModel)
    case profile(ProfileViewModel)
    case book(BookViewModel)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .addText(let viewModel):
            AddTextView(viewModel: viewModel)
        
        case .addEntryView(let viewModel):
            AddEntryView(viewModel: viewModel)
            
        case .profile(let viewModel):
            ProfileView(viewModel: viewModel)
            
        case .book(let viewModel):
            BookView(viewModel: viewModel)
        }
    }
    
    var showsFloatingNavigation: Bool {
        switch self {
        case .profile, .book:
            true
            
        default:
            false
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
