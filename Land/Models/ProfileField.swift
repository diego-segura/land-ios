//
//  ProfileField.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

struct ProfileField: Identifiable, Equatable, Hashable {
    let id = UUID().uuidString
    let title: String
    let type: FieldType
    let placeholder: String
    var isMandatory: Bool = false
    var text: String = ""
    
    enum FieldType {
        case username
        case name
        case instagram
        case twitter
        case website
        case location
        case bio
        
        var contentType: UITextContentType? {
            switch self {
            case .username:
                .username
            case .name:
                .name
            case .instagram:
                .username
            case .twitter:
                .username
            case .website:
                .URL
            case .location:
                .location
            case .bio:
                nil
            }
        }
        
        var submitLabel: SubmitLabel {
            switch self {
            case .bio:
                .done
                
            default:
                .continue
            }
        }
    }
}
