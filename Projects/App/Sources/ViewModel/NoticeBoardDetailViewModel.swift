//
//  NoticeBoardDetailViewModel.swift
//  babya
//
//  Created by hyk on 6/12/24.
//

import Foundation
import Alamofire

class NoticeBoardDetailViewModel: ObservableObject {
    @Published var postListModel = PostListResponse()
    @Published var model = NoticeBoardDetailModel()
    @Published var commentModel = PostCommentModel()
    @Published var commentResponse = PostCommentResponse()
    
    func getPostDetail(postId: Int) {
        AF.request("\(ApiContent.url)/post/\(postId)", method: .get, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("*/*")])
            .responseDecodable(of: NoticeBoardDetailModel.self) { response in
                switch response.result {
                case .success(let data):
                    self.model = data
                case .failure(let error):
                    if let data = response.data {
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "Cannot decode data")")
                    }
                    print("Decoding error: \(error)")
                }
            }
    }
    
    func postComment(postId: Int) {
        var params: [String: Any] {
            return [
                "comment": commentModel.comment,
                "parentCommentId": commentModel.parentCommentId,
                "postId": postId
            ]
        }
        
        AF.request("\(ApiContent.url)/post/comment", method: .post, parameters: params, encoding: JSONEncoding.default, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("application/json")])
            .response { response in
                switch response.result {
                case .success(_):
                    self.getComment(page: 1, size: 10, postId: postId)
                    self.getPostDetail(postId: postId)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getComment(page: Int, size: Int, postId: Int) {
        let params: [String : Any] = [
            "page" : page,
            "size" : size,
            "postId" : postId
        ]
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/post/comment")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                
        guard let url = urlComponents.url else { return }
        
        AF.request(url, method: .get, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("application/json")])
            .responseDecodable(of: PostCommentResponse.self) { response in
                switch response.result {
                case.success(let data):
                    self.commentResponse = data
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
