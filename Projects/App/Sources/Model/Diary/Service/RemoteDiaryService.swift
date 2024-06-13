//
//  RemoteDiaryService.swift
//  babya
//
//  Created by dgsw8th61 on 6/13/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

final class RemoteDiaryService : DiaryService{
    func diary(request: DiaryRequest) async throws -> baseResponse {
        let url = "diary"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
                .responseDecodable(of: baseResponse.self) { response in
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
