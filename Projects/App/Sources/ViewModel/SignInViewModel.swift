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

@MainActor
class SignInViewModel: ObservableObject {
    @Published var is401Error: Bool = false
    @Published var is404Error: Bool = false
    
    func performLogin(email: String, password: String) async throws -> Response<LoginResponse>{
        let loginRequest = LoginRequest(email: email, pw: password)
        let url = "auth/login"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url, method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default)
                .responseDecodable(of: Response<LoginResponse>.self) { response in
                    switch response.result {
                    case .success(let responseData):
                        print(responseData)
                        continuation.resume(returning: responseData)
                        switch responseData.status{
                        case 401:
                            self.is401Error = true
                            print("401 비밀번호 틀림")
                        case 404:
                            self.is404Error = true
                            print("404 이메일 틀림")
                        default:
                            print("error")
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                        print(error)
                    }
                }
        }
    }
}
