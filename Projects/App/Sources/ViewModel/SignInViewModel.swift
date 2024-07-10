//
//  SignInViewModel.swift
//  babya
//
//  Created by dgsw8th61 on 5/12/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import Alamofire
import Combine
import SwiftUI

@MainActor
class SignInViewModel: ObservableObject {
    @Published var is401Error: Bool = false
    @Published var is404Error: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var success : Bool = false
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    func login(email: String, password: String) async {
            do {
                let response = try await authService.login(email: email, password: password)
                
                print(response.message)
                switch response.status {
                case 200:
                    isLoggedIn = true
                    LoginUserHashCache.shared.storeAccessToken(value: response.data?.accessToken ?? "")
                    LoginUserHashCache.shared.storeRefreshToken(value: response.data?.refreshToken ?? "")
                    
                    print(LoginUserHashCache.accessToken)
                    
                    print(LoginUserHashCache.shared.checkAccessToken())
                    
                    
                    
                    DispatchQueue.main.async {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                        let rootViewController = windowScene.windows.first?.rootViewController {
                            let homeView = UIHostingController(rootView: NavigationView { HomeView() })
                            homeView.modalPresentationStyle = .fullScreen
                            rootViewController.present(homeView, animated: true, completion: nil)
                        }
                    }
              
                    
                    LoginUserHashCache.shared.storeEmail(value: email) 
                    print(response)
                case 401:
                    is401Error = true
                case 404:
                    is404Error = true
                default:
                    print("알 수 없는 오류가 발생했습니다.")
                }
            } catch {
                print(error)
            }
        }
}
