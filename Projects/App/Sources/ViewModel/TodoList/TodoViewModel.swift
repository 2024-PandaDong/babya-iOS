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
    @Published var todoResponse: TodoResponse = .init()
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
        
        AF.request(
            urlComponents.url ?? "",
            method: .get,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
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
        AF.request(
            "\(ApiContent.url)/todo/category",
            method: .get,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
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
        AF.request(
            "\(ApiContent.url)/todo",
            method: .post,
            parameters: model.params,
            encoding: JSONEncoding.default,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
        .response { response in
            switch response.result {
            case .success(_):
                self.getTodo(category: self.currentTab, date: self.dateFormatter.string(from: self.date))
                self.getCategory()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteTodo(id: Int) {
        AF.request(
            "\(ApiContent.url)/todo/\(id)",
            method: .delete,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
        .validate()
        .responseJSON { json in
            print(json)
        }
        .response { response in
            switch response.result {
            case .success(_):
                self.getTodo(category: self.currentTab, date: self.dateFormatter.string(from: self.date))
                self.getCategory()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func editTodo(id: Int, category: String, content: String, planedDt: String) {
        let params: [String: Any] = [
            "id": id,
            "category": category,
            "content": content,
            "planedDt": planedDt
        ]
        
        AF.request(
            "\(ApiContent.url)/todo",
            method: .patch,
            parameters: params,
            encoding: JSONEncoding.default,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
        .responseJSON { json in
            print(json)
        }
        .response { response in
            switch response.result {
            case .success(_):
                self.getTodo(category: self.currentTab, date: self.dateFormatter.string(from: self.date))
                self.getCategory()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func todoCheck(isChecked: Bool, id: Int) {
        let params: [String: Any] = [
            "isChecked": isChecked,
            "id": id
        ]
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/todo/check")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        
        AF.request(
            urlComponents ?? "",
            method: .patch,
            encoding: JSONEncoding.default,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
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
        let allDates = todoResponse.data.map { $0.planedDt }
        self.uniqueDates = Array(Set(allDates)).sorted()
    }
    
}
