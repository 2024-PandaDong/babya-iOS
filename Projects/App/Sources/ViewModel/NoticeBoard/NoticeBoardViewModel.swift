//
//  NoticeBoardViewModel.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import Foundation
import Alamofire

class NoticeBoardViewModel: ObservableObject {
    @Published var model = PostListResponse()
    
    func getPosts(page: Int, size: Int, category: String) {
        let params: [String : Any] = [
            "page" : page,
            "size" : size,
            "category" : category
        ]
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/post/list")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                
        guard let url = urlComponents.url else { return }
        
        AF.request(url, method: .get, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("application/json")])
            .responseDecodable(of: PostListResponse.self) { response in
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
