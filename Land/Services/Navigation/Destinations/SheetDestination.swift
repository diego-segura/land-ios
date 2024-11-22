//
//  SheetDestination.swift
//  YPages
//
//  Created by Luka Vujnovac on 27.07.2024..
//

import SwiftUI

protocol SheetDestination: Identifiable {
    associatedtype ViewType: View
    var destination: ViewType { get }
    var dragIndicatorVisibility: Visibility { get }
    var sheetDetents: Set<PresentationDetent> { get }
}
