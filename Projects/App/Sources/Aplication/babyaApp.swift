//
//  babyaApp.swift
//  ProjectDescriptionHelpers
//
//  Created by dgsw8th32 on 4/21/24.
//

import SwiftUI

@main
struct babyaApp: App {
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            ZStack {
                if LoginUserHashCache.shared.checkAccessToken() == nil {
                    SignInView(vm: SignInViewModel(authService: RemoteAuthService()))
                } else {
                    DiaryView(vm: DiaryViewModel(diaryService: RemoteDiaryService()))
                }
            }
//            .onAppear{
//                LoginUserHashCache.shared.logout()
//            }
        }
    }
}

