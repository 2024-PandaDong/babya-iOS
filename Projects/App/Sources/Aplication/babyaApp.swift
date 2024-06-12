//
//  babyaApp.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th32 on 4/21/24.
//

import SwiftUI

@main
struct babyaApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack{
                DiaryView()
//                SignInView( vm: SignInViewModel(authService: RemoteAuthService()))
//                DiaryWritingView(title: "테스트", PostName: "텟그트", DiaryImage: "Image")
//                if LoginUserHashCache.accessToken.isEmpty {
//                    SignInView( vm: SignInViewModel(authService: RemoteAuthService()))
//                } else {
//                    DiaryView()
//                }
            }
        }
    }
}
