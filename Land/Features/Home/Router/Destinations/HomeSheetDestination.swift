//
//  HomeSheetDestination.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

enum HomeSheetDestination: SheetDestination {
    
    var destination: some View {
        EmptyView()
    }
    
    var dragIndicatorVisibility: Visibility { .hidden }
    var sheetDetents: Set<PresentationDetent> { [] }
}

extension HomeSheetDestination {
    var id: String {
        String(describing: self)
    }
}
