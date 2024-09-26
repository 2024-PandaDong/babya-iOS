//
//  RemoteAuthService.swift
//  babya
//
//  Created by dgsw8th61 on 5/18/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

final class RemoteAuthService: AuthService {
    func login(email: String, password: String) async throws -> Response<LoginResponse> {
        
        let loginRequest = LoginRequest(email: email, pw: password)
        let loginUrl = "/auth/login"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(ApiContent.url + loginUrl, method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default)
                .responseDecodable(of: Response<LoginResponse>.self) { response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    func reissue(refreshToken: String) async throws -> Response<ReissueResponse> {
        let reissueRequest = ReissueRequest(refreshToken: refreshToken)
        let reissueUrl = "/auth/reissue"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(ApiContent.url + reissueUrl, method: .post, parameters: reissueRequest, encoder: JSONParameterEncoder.default, interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<ReissueResponse>.self) { response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
