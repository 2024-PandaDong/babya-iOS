//
//  babyaApp.swift
//  babya
//
//  Created by dgsw8th32 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI
import FlowKit
import KakaoMapsSDK
import KakaoMapsSDK_SPM

@main
struct babyaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String {
            SDKInitializer.InitSDK(appKey: kakaoAppKey)
        } else {
            fatalError("Kakao App Key is missing in Info.plist")
        }
        return true
    }
}
