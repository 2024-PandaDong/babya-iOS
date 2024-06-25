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
    
    func getDiary(pageRequest: PageRequest,email : String) async throws -> Response<[DiaryResponse]> {
        let url = "diary?page=\(pageRequest.page)&size=\(pageRequest.size)&email=\(email)"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request( baseUrl + url, method: .get,interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<[DiaryResponse]>.self) { response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getCommentDiary(pageRequest: PageRequest, diaryId: Int) async throws -> Response<[CommentResponse]> {
        let url = "diary/comment?page=\(pageRequest.page)&size=\(pageRequest.size)&diaryId=\(diaryId)"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url,method: .get,interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<[CommentResponse]>.self){ response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                    
                }
        }
    }
    //
    //    func postCommentDiary(request: CommentRequest) async throws -> baseResponse {
    //        let url = "diary/comment"
    //    }
    //
    //    func deleteCommentDiary(id: Int) async throws -> baseResponse {
    //        let url = "diary/\(id)"
    //    }
    //
    func getDetailDiary(id: Int) async throws -> Response<DiaryResponse> {
        let url = "diary/\(id)"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url,method: .get,interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<DiaryResponse>.self){ response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                    
                }
        }
    }
    
    func getSubComment(pageRequest: PageRequest, parentId: Int) async throws -> Response<[SubCommentResponse]> {
        let url = "diary/sub-comment?page=\(pageRequest.page)&size=\(pageRequest.size)&parentId=\(parentId)"
        return try await withCheckedThrowingContinuation {continuation in
            AF.request(baseUrl + url,method:.get,interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<[SubCommentResponse]>.self){ response in
                    switch response.result {
                    case.success(let responseData):
                        continuation.resume(returning: responseData)
                    case.failure(let error):
                        continuation.resume(throwing: error)
                    }
                    
                }
        }
    }
    
    func stausWeekDiary() async throws -> Response<DiaryWeekStausResponse> {
        let url = "diary/staus/week"
        return try await withCheckedThrowingContinuation {continuation in
            AF.request(baseUrl + url,method:.get,interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<DiaryWeekStausResponse>.self){ response in
                    switch response.result {
                    case.success(let responseData):
                        continuation.resume(returning: responseData)
                    case.failure(let error):
                        continuation.resume(throwing: error)
                    }
                    
                }
        }
    }
    
    func getListDiary(pageRequest: PageRequest) async throws -> Response<[DiaryResponse]> {
        let url = "diary/list?page=\(pageRequest.page)&size=\(pageRequest.size)"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(baseUrl + url,method: .get,interceptor: MyRequestInterceptor())
                .responseDecodable(of: Response<[DiaryResponse]>.self){ response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                    
                }
        }
    }
    
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
