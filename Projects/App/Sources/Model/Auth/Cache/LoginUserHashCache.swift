//
//  LoginUserHashCache.swift
//  babya
//
//  Created by dgsw8th61 on 5/22/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct LoginUserHashCache {
    static let shared = LoginUserHashCache()
    private init () {}
    static var accessToken = "accessToken"
    static var refreshToken = "refreshToken"
    static var email = "email"
    
    func checkAccessToken() -> String? {
        if let accessToken = UserDefaults.standard.object(forKey: LoginUserHashCache.accessToken) as? String {
            return accessToken
        }
        return nil
    }
    
    func checkRefreshToken() -> String? {
        if let refreshToken = UserDefaults.standard.object(forKey: LoginUserHashCache.refreshToken) as? String {
            return refreshToken
        }
        return nil
    }
    
    func checkEmail() -> String? {
        if let email = UserDefaults.standard.object(forKey: LoginUserHashCache.email) as? String {
            return email
        }
        return nil
    }
    
    func storeEmail(value: String){
        UserDefaults.standard.set(value, forKey: LoginUserHashCache.email)
    }
    
    func storeAccessToken(value: String){
        UserDefaults.standard.set(value, forKey: LoginUserHashCache.accessToken)
    }
    
    func storeRefreshToken(value: String){
        UserDefaults.standard.set(value, forKey: LoginUserHashCache.refreshToken)
    }

    
    func logout(){
        UserDefaults.standard.removeObject(forKey: LoginUserHashCache.accessToken)
    }
}
