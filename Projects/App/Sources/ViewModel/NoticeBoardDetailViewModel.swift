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
    
    func getPostDetail(postId: Int) {
        AF.request("\(ApiContent.url)/post/\(postId)", method: .get, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken)])
            .responseJSON { json in
                print(json)
            }
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
}
