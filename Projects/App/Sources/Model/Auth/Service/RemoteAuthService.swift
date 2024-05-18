//
//  RemoteAuthService.swift
//  babya
//
//  Created by dgsw8th61 on 5/18/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import Alamofire

final class RemoteAuthService: AuthService {
    func login(email: String, password: String) async throws -> Response<LoginResponse> {
        let loginRequest = LoginRequest(email: email, pw: password)
        let url = "auth/login"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url, method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default)
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
}
