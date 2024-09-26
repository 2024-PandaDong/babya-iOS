//
//  RemoteNoticeBoardService.swift
//  babya
//
//  Created by hyk on 7/11/24.
//

import Foundation
import Alamofire
import SwiftUI

final class RemoteNoticeBoardService: NoticeBoardService {
    func getCommentPost(pageRequest: PageRequest, postId: Int) async throws -> Response<[CommentResponse]> {
        let url = "/post/comment?page=\(pageRequest.page)&size=\(pageRequest.size)&postId=\(postId)"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(ApiContent.url + url,method: .get,interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
                .responseJSON { json in
                    print(json)
                }
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
    
    func postCommentPost(request: PostCommentRequest) async throws -> baseResponse {
        let url = "/post/comment"

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(ApiContent.url + url, method: .post, parameters: request, encoder: JSONParameterEncoder.default, interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
                .responseJSON { json in
                    print("Raw JSON response: \(json)")
                }
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

    
    func deleteCommentPost(id: Int) async throws -> baseResponse {
        let url = "/post/\(id)"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(ApiContent.url + url,method: .delete,interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
                .responseDecodable(of: baseResponse.self){ response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                    
                }
        }
    }
    
    func getPostSubComment(pageRequest: PageRequest, parentId: Int) async throws -> Response<[SubCommentResponse]> {
        let url = "/post/sub-comment?page=\(pageRequest.page)&size=\(pageRequest.size)&parentId=\(parentId)"
        return try await withCheckedThrowingContinuation {continuation in
            AF.request(ApiContent.url + url,method:.get,interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
                .responseJSON { json in
                    print(json)
                }
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
    
    

}
