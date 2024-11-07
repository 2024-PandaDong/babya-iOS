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
    @StateObject private var flow = FlowProvider(rootView: RootView())

    var body: some Scene {
        WindowGroup {
            if LoginUserHashCache.shared.checkAccessToken() == nil {
                FlowPresenter(rootView: RootView())
                    .environmentObject(flow) // FlowProvider 환경 객체 추가
            } else {
                FlowPresenter(rootView: QuizView(vm: QuizViewModel(quizService: RemoteQuizService())))
            }
        }
    }
}
