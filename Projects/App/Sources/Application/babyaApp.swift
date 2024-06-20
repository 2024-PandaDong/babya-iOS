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
//            ZStack{
//                SignInView(vm: SignInViewModel(authService: RemoteAuthService()))
//            }
            NavigationView {
                if LoginUserHashCache.accessToken.isEmpty {
                    SignInView( vm: SignInViewModel(authService: RemoteAuthService()))
                } else {
                    HomeView()
                }
            }
        }
    }
}
