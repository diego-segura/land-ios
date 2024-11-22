//
//  PushDestination.swift
//  YPages
//
//  Created by Luka Vujnovac on 27.07.2024..
//

import SwiftUI

protocol PushDestination: Hashable, Identifiable {
    associatedtype ViewType: View
    var destination: ViewType { get }
}
