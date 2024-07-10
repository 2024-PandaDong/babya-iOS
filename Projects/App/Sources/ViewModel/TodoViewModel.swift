//
//  TodoViewModel.swift
//  babya
//
//  Created by hyk on 6/27/24.
//

import Foundation
import Alamofire
import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var model = TodoModel()
    @Published var currentTab: String = ""
    @Published var date: Date = .now
    @Published var todoResponse = TodoResponse()
    @Published var categoryResponse = CategoryResponse()
    @Published var uniqueDates: [String] = []
    @Published var todoList: [String: Any] = ["":""]
    
    var dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var isPostAvailable: Bool {
        return !model.content.isEmpty && !model.category.isEmpty
    }
    
    func changeCategory(currentTab: String = "") {
        self.currentTab = currentTab
        self.getTodo(category: currentTab, date: self.dateFormatter.string(from: self.date))
    }
    
    func getTodo(category: String, date: String) {
        let params: [String: Any] = [
            "category": category,
            "date": date
        ]
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/todo")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        AF.request(urlComponents.url ?? "", method: .get, headers: [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ])
        .responseDecodable(of: TodoResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.todoResponse = data
                self.updateUniqueDates()
                print("Todo 불러오기 성공")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getCategory() {
        AF.request("\(ApiContent.url)/todo/category", method: .get, headers: [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ])
        .responseDecodable(of: CategoryResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.categoryResponse = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postTodo() {
        AF.request("\(ApiContent.url)/todo", method: .post, parameters: model.params, encoding: JSONEncoding.default, headers: [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ])
        .response { response in
            switch response.result {
            case .success(_):
                self.getTodo(category: self.currentTab, date: self.dateFormatter.string(from: self.date))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteTodo(id: Int) {
        AF.request("\(ApiContent.url)/todo/\(id)", method: .delete, headers: [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken)])
            .validate()
            .responseJSON { json in
                print(json)
            }
            .response { response in
                switch response.result {
                case .success(_):
                    self.getTodo(category: self.currentTab, date: self.dateFormatter.string(from: self.date))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func editTodo() {
        
    }
    
    func todoCheck(isChecked: Bool, id: Int) {
        let params: [String: Any] = [
            "isChecked": isChecked,
            "id": id
        ]
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/todo/check")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        AF.request(urlComponents ?? "", method: .patch, encoding: JSONEncoding.default, headers: [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ])
        .responseJSON { json in
            print(json)
        }
        .response { response in
            switch response.result {
            case .success(_):
                self.getTodo(category: self.currentTab, date: self.dateFormatter.string(from: self.date))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUniqueDates() {
        if let data = todoResponse.data {
            let allDates = data.map { $0.planedDt }
            self.uniqueDates = Array(Set(allDates)).sorted()
        }
    }
}
