//
//  CreateProfileView.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import SwiftUI

struct CreateProfileView: View {
    
    @State private var showImagePicker: Bool = false
    @FocusState private var focusedField: ProfileField.FieldType?
    
    @StateObject private var viewModel: CreateProfileViewModel
    
    init(viewModel: @autoclosure @escaping () -> CreateProfileViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 62) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("fill out your profile")
                        .font(.standard(size: 24, weight: 310))
                        .fontWeight(.light)
                    
                    Text("you can always edit it later")
                        .font(.standard(size: 14, weight: 360))
                        .foregroundStyle(Color.custom(hex: "999999"))
                }
                VStack(alignment: .leading, spacing: 30) {
                    TextField("@username", text: $viewModel.state.username)
                        .textFieldStyle(.profile(field: ProfileField(title: "claim a handle", type: .username, placeholder: "@username")))
                        .focused($focusedField, equals: .username)
                    image
                    ForEach($viewModel.state.fields) { $field in
                        TextField(field.placeholder, text: $field.text, axis: field.type == .bio ? .vertical : .horizontal)
                            .textFieldStyle(.profile(field: field))
                            .focused($focusedField, equals: field.type)
                    }
                }
            }
            .padding(.top, 91)
        }
        .scrollIndicators(.hidden)
        .safeAreaPadding(.horizontal, 22)
        .safeAreaInset(edge: .bottom) {
            Rectangle()
                .ignoresSafeArea()
                .allowsHitTesting(false)
                .frame(height: 139)
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .white,
                            .white.opacity(0)
                        ],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .overlay {
                    if viewModel.state.canSubmit {
                        Button {
                            viewModel.trigger(.onSubmit)
                        } label: {
                            HStack {
                                Text("next")
                                    .font(.standard(size: 16, weight: 360))
                                    .foregroundStyle(.brandDark)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.brandDark)
                            }
                        }
                        .buttonStyle(.bigHighlighted)
                        .padding(.horizontal, 10)
                        .transition(.blurReplace)
                        .padding(.top, 33)
                    }
                }
        }
        .cropImagePicker(
            options: [.circle],
            show: $showImagePicker,
            croppedImage: $viewModel.state.croppedImage
        )
        .onAppear {
            focusedField = .username
        }
        .onChange(of: viewModel.state.fields) {
            viewModel.trigger(.checkSubmit)
        }
        .onSubmit {
            switch focusedField {
            case .username:
                focusedField = nil
            case .name:
                focusedField = .instagram
            case .instagram:
                focusedField = .twitter
            case .twitter:
                focusedField = .website
            case .website:
                focusedField = .location
            case .location:
                focusedField = .bio
            case .bio:
                focusedField = nil
            case nil:
                break
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.smooth, value: viewModel.state.canSubmit)
    }
    
    @ViewBuilder
    private var image: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("add a profile picture")
                .font(.standard(size: 14, weight: 360))
                .foregroundStyle(Color.custom(hex: "999999"))
            
            if let croppedImage = viewModel.state.croppedImage {
                Image(uiImage: croppedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 112, height: 112)
            } else {
                Button {
                    showImagePicker.toggle()
                } label: {
                    Circle()
                        .frame(width: 112, height: 112)
                        .foregroundStyle(Color.custom(hex: "F2F2F2"))
                        .overlay {
                            Image(systemName: "plus.viewfinder")
                                .font(.title)
                                .foregroundStyle(.black)
                        }
                }
            }
        }
    }
}

#Preview {
    CreateProfileView(viewModel: CreateProfileViewModel())
}
