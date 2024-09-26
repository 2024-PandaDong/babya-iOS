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
                if (LoginUserHashCache.shared.checkAccessToken() == nil) {
                    RootView()
                } else {
                    QuizView(vm: QuizViewModel(quizService: RemoteQuizService()))
                        .onAppear{
                            LoginUserHashCache.shared.storeAccessToken(value: "eyJKV1QiOiJBQ0NFU1MiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJla2l5YSIsInN1YiI6Inlvb25jaGFlMjAxNUBnbWFpbC5jb20iLCJBdXRob3JpemF0aW9uIjoiTUVNQkVSIiwiaWF0IjoxNzI3MzM5Mzg2LCJleHAiOjE3Mjg1NDg5ODZ9.RmeNy1b74Ftk1xCHjKDFV4G2F5HJ1xC72jZTmjYQSrUA_FFcGaZAbZKIEC5kMYdGTrmuZB_8ZO1Zr3xMBZAyz" )
                        }
                }
            }
        }
    }
}
