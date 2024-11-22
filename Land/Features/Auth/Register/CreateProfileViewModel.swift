//
//  CreateProfileViewModel.swift
//  Land
//
//  Created by Luka Vujnovac on 22.11.2024..
//

import Dependencies
import UIKit

class CreateProfileViewModel: ObservableObject {
    
    @Dependency(\.authService) private var authService
    @Published var state = ViewState()
    
    func trigger(_ action: Action) {
        switch action {
        case .onSubmit:
            handleSubmit()
            
        case .checkSubmit:
            checkSubmit()
        }
    }
}

extension CreateProfileViewModel {
    enum Action {
        case onSubmit
        case checkSubmit
    }
    
    struct ViewState {
        var fields: [ProfileField] = [
            ProfileField(title: "what's your name", type: .name, placeholder: "John Appleseed", isMandatory: true),
            ProfileField(title: "what's your instagram", type: .instagram, placeholder: "@username"),
            ProfileField(title: "what's your twitter", type: .twitter, placeholder: "@username"),
            ProfileField(title: "what's your website/portfolio", type: .website, placeholder: "https://you.com"),
            ProfileField(title: "where are you based?", type: .location, placeholder: "Cupertino, California"),
            ProfileField(title: "tell us a bit about yourself", type: .bio, placeholder: "Just a chill guy.")
        ]
        var username = ""
        var croppedImage: UIImage?
        var canSubmit = false
    }
}

private extension CreateProfileViewModel {
    func checkSubmit() {
        let mandatoryFields = state.fields.filter { $0.isMandatory }
        state.canSubmit = !mandatoryFields.contains(where: \.text.isEmpty)
    }
    
    func handleSubmit() {
        guard let name = state.fields.first(where: { $0.type == .name })?.text else { return }
        let instagram = state.fields.first(where: { $0.type == .instagram })?.text
        let twitter = state.fields.first(where: { $0.type == .twitter })?.text
        let website = state.fields.first(where: { $0.type == .website })?.text
        let location = state.fields.first(where: { $0.type == .location })?.text
        let bio = state.fields.first(where: { $0.type == .bio })?.text
        
        let user = User(
            username: state.username,
            name: name,
            instagramUsername: instagram,
            twitterUsername: twitter,
            websiteUrl: website,
            location: location,
            bio: bio,
            imageData: state.croppedImage?.pngData()
        )
        
        LocalStorage.userProfile = user
        authService.logIn()
    }
}


