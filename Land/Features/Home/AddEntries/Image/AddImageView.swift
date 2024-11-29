//
//  AddImageView.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import PhotosUI
import SwiftUI

struct AddImageView: View {
    
    @State var showImagePicker: Bool = false
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        ZStack {
            ForEach(1..<5, id: \.self) { index in
                Image("pic\(index)")
                    
            }
        }
    }
}

#Preview {
    AddImageView()
}

