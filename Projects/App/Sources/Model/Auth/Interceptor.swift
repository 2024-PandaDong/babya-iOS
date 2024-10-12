//
//  Interceptor.swift
//  babya
//
//  Created by dgsw8th61 on 5/23/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import Alamofire


final class MyRequestInterceptor: RequestInterceptor {
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + (LoginUserHashCache.shared.checkAccessToken() ?? ""), forHTTPHeaderField: "Authorization")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let url = request.request?.url else {
            completion(.doNotRetryWithError(error))
            return
        }
        print("URL String: \(url.absoluteString)")
        
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401, !url.absoluteString.contains("refresh") else {
            completion(.doNotRetryWithError(error))
            return
        }
        
        let refreshToken = LoginUserHashCache.shared.checkRefreshToken()
        
        print("리프레시 토큰 :\(String(describing: refreshToken))")
        
        Task {
            do {
                let response = try await authService.reissue(refreshToken: refreshToken ?? "")
                print(response)
                guard let accessToken = response.data?.accessToken else {
                    completion(.doNotRetryWithError(NSError(domain: "AuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Access token is missing"])))
                    return
                }
                
                LoginUserHashCache.shared.storeAccessToken(value: accessToken)
                completion(.retry)
            } catch {
                print("error")
                completion(.doNotRetryWithError(error))
            }
        }
    }
}
