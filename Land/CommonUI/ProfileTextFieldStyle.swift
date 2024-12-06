//
//  ProfileTextFieldStyle.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

struct ProfileTextFieldStyle: TextFieldStyle {
    
    let input: ProfileField
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Text(input.title)
                    .font(.standard(.subheadline, weight: .medium))
                    .foregroundStyle(Color.custom(hex: "999999"))
                
                if !input.isMandatory {
                    Text("OPTIONAL")
                        .font(.standard(size: 10, weight: 420))
                        .fontWeight(.medium)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .textContentType(input.type.contentType)
                        .foregroundStyle(Color.custom(hex: "999999"))
                        .frame(height: .heightForFontSize(size: 10))
                        .padding(.horizontal, 3.5)
                        .padding(.top, 8.5)
                        .padding(.bottom, 7)
                        .background(Color.custom(hex: "#F2F2F2"), in: .rect(cornerRadius: 2))
                }
            }
            
            configuration
                .font(.standard(size: 24, weight: 310))
                .foregroundStyle(.black)
                .tint(.black)
                .kerning(-0.48)
                .submitLabel(input.type.submitLabel)
        }
    }
}

extension TextFieldStyle where Self == ProfileTextFieldStyle {
    static func profile(field: ProfileField) -> Self {
        ProfileTextFieldStyle(input: field)
    }
}

#Preview {
    @Previewable @State var input = ProfileField(title: "claim a handle", type: .bio, placeholder: "@username", isMandatory: false)
    TextField(input.placeholder, text: $input.text)
        .textFieldStyle(.profile(field: input))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
}
