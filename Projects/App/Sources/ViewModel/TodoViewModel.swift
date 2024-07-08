//
//  TodoViewModel.swift
//  babya
//
//  Created by hyk on 6/27/24.
//

import Foundation
import Alamofire

class TodoViewModel: ObservableObject {
    @Published var model = TodoModel()
    @Published var categoryResponse = CategoryResponse()
    
    var isPostAvailable: Bool {
        get {
            return !model.content.isEmpty && !model.category.isEmpty
        }
    }
    
    func getTodo(category: String, date: String) {
        var params: [String: Any] {
            return [
                "category": category,
                "date": date
            ]
        }
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/todo")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        AF.request(urlComponents.url ?? "", method: .get, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("application/json")])
            .responseJSON { response in
                print(response)
            }
    }
    
    func getCategory() {
        AF.request("\(ApiContent.url)/todo/category", method: .get, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("application/json")])
            .responseDecodable(of: CategoryResponse.self) { response in
                switch response.result {
                case.success(let data):
                    self.categoryResponse = data
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func postTodo() {
        AF.request("\(ApiContent.url)/todo", method: .post, parameters: model.params, encoding: JSONEncoding.default, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("application/json")])
            .responseJSON { json in
                print(json)
            }
    }
}
