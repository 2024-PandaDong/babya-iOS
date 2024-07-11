//
//  RemoteQuizService.swift
//  babya
//
//  Created by dgsw8th61 on 7/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import Alamofire

final class RemoteQuizService: QuizService {
    func getQuiz() async throws -> Response<QuizResponse>{
        let url = "quiz"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url,method: .get,interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<QuizResponse>.self){ response in
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
