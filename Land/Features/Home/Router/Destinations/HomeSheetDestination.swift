//
//  HomeSheetDestination.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

enum HomeSheetDestination: SheetDestination {
    
    case addEntriesMenu
    
    var destination: some View {
        switch self {
        case .addEntriesMenu:
            AddEntriesMenuView()
        }
    }
    
    var dragIndicatorVisibility: Visibility { .hidden }
    var sheetDetents: Set<PresentationDetent> { [] }
}

extension HomeSheetDestination {
    var id: String {
        String(describing: self)
    }
}
