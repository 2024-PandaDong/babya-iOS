//
//  babyaApp.swift
//  babya
//
//  Created by dgsw8th32 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

@main
struct babyaApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if (LoginUserHashCache.shared.checkAccessToken() != nil) {
                    HomeView()
                } else {
                    SignInView( vm: SignInViewModel(authService: RemoteAuthService()))
                }
            }
        }
    }
}
