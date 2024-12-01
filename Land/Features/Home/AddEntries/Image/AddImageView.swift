//
//  AddImageView.swift
//  Land
//
//  Created by Luka Vujnovac on 28.11.2024..
//

import PhotosUI
import SwiftUI

struct AddImageView: View {
    
    @State private var showPhotosPicker = false
    @State private var selectedItem: PhotosPickerItem?
    @StateObject private var viewModel: AddImageViewModel
    
    init(viewModel: @autoclosure @escaping () -> AddImageViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 12) {
                Text("add photos")
                    .font(.standard(size: 24, weight: 310))
                    .kerning(-0.48)
                Text("select one")
                    .font(.standard(size: 14, weight: 360))
                    .kerning(-0.14)
                    .foregroundStyle(Color.custom(hex: "999999"))
            }
            .padding(.horizontal, 22)
            
            VStack(spacing: 0) {
                Divider()
                if let image = viewModel.state.selectedItem {
                    Image(uiImage: UIImage(data: image) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 24))
                        .shadow(color: .black.opacity(0.1), radius: 25, x: 0, y: 0)
                        .frame(maxHeight: .infinity)
                }
                Spacer()
            }
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItem)
        .safeAreaInset(edge: .bottom) {
            Button {
                viewModel.trigger(.onNext)
            } label: {
                HStack {
                    Text("next")
                        .font(.standard(size: 16, weight: 360))
                        .foregroundStyle(.brandDark)
                        .kerning(-0.14)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .font(.system(size: 16))
                        .foregroundStyle(.brandDark)
                }
                .padding(.vertical, 8)
                .padding(.leading, 23)
                .padding(.trailing, 19)
            }
            .disabled(!viewModel.state.canGoNext)
            .buttonStyle(.highlighted)
            .clipShape(.rect(cornerRadius: 24))
            .padding(.horizontal, 10)
            .padding(.bottom, 13)
        }
        .padding(.top, 50)
        .customBackButton {
            viewModel.trigger(.onPop)
        }
        .onAppear {
            showPhotosPicker = true
        }
        .onChange(of: selectedItem) { _, newValue in
            Task {
                if let loadedData = try? await selectedItem?.loadTransferable(type: Data.self),
                   let originalImage = UIImage(data: loadedData) {
                    // Compress the image to a lower quality (e.g., 0.5 for 50%)
                    if let compressedData = originalImage.jpegData(compressionQuality: 0.5) {
                        viewModel.state.selectedItem = compressedData
                        viewModel.trigger(.onStateChange)
                    } else {
                        print("Failed to compress image")
                    }
                } else {
                    print("Failed to load image")
                }
            }
        }
    }
}

#Preview {
    AddImageView(viewModel: AddImageViewModel())
}

