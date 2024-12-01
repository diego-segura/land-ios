//
//  HomePushDestination.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

enum HomePushDestination: PushDestination {
    
    case addCaption(AddCaptionViewModel)
    case addEntryView(AddEntryViewModel)
    case addImage(AddImageViewModel)
    case addText(AddTextViewModel)
    case createBook(CreateBookViewModel)
    case profile(ProfileViewModel)
    case book(BookViewModel)
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .addCaption(let viewModel):
            AddCaptionView(viewModel: viewModel)
            
        case .addImage(let viewModel):
            AddImageView(viewModel: viewModel)
            
        case .addText(let viewModel):
            AddTextView(viewModel: viewModel)
        
        case .addEntryView(let viewModel):
            AddEntryView(viewModel: viewModel)
            
        case .createBook(let viewModel):
            CreateBookView(viewModel: viewModel)
            
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
