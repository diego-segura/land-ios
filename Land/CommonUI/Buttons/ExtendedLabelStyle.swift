//
//  ExtendedLabelStyle.swift
//  Land
//
//  Created by Franco Miguel Guevarra on 12/5/24.
//

import SwiftUI

struct ExtendedLabelStyle: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
                .frame(maxWidth: .infinity, alignment: .leading)
            
            configuration.icon
        }
    }
    
}
