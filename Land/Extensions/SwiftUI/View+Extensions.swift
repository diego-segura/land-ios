//
//  View+Extensions.swift
//  Land
//
//  Created by Luka Vujnovac on 20.11.2024..
//

import SwiftUI

extension View {
    
    var safeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
    var noteAnimation: Animation {
        .smooth(duration: 0.3, extraBounce: 0)
    }
}
