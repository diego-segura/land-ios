//
//  AuthSheetDestination.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

enum AuthSheetDestination: SheetDestination {
    
    var destination: some View {
        EmptyView()
    }
    
    var dragIndicatorVisibility: Visibility { .hidden }
    var sheetDetents: Set<PresentationDetent> { [] }
}

extension AuthSheetDestination {
    var id: String {
        String(describing: self)
    }
}
