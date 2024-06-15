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

//    func getDiary(request: PageRequest) async throws -> Response<DiaryResponse> {
//        let url = "diary"
//
//    }
//    
//    func getCommentDiary(pageRequest: PageRequest, diaryId: Int) async throws -> Response<CommentResponse> {
//        let url = "diary/comment"
//    }
//    
//    func postCommentDiary(request: CommentRequest) async throws -> baseResponse {
//        let url = "diary/comment"
//    }
//    
//    func deleteCommentDiary(id: Int) async throws -> baseResponse {
//        let url = "diary/\(id)"
//    }
//    
//    func getDetailDiary(id: Int) async throws -> Response<DiaryResponse> {
//        let url = "diary/\(id)"
//    }
//    
//    func getSubComment(pageRequest: PageRequest, parentId: Int) async throws -> Response<SubCommentResponse> {
//        let url = "diary/sub-comment"
//    }
//    
//    func stausWeekDiary() async throws -> Response<DiaryWeekStausResponse> {
//        let url = "diary/staus/week"
//    }
//    
//    func getMyDiary(pageRequest: PageRequest) async throws -> Response<DiaryResponse> {
//        let url = "diary/my"
//    }
    
    func postDiary(request: DiaryRequest) async throws -> baseResponse {
        let url = "diary"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url, method: .post, parameters: request, encoder: JSONParameterEncoder.default,interceptor: MyRequestInterceptor())
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
