//
//  babyaApp.swift
//  babya
//
//  Created by dgsw8th32 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI
import FlowKit

@main
struct babyaApp: App {
    var body: some Scene {
        WindowGroup {
                if (LoginUserHashCache.shared.checkAccessToken() == nil) {
                    FlowPresenter(rootView: RootView())
                } else {
                    FlowPresenter(rootView: QuizView(vm: QuizViewModel(quizService: RemoteQuizService())))
                }
        }
    }
}
