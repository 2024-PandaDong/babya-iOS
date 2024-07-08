//
//  TodoModel.swift
//  babya
//
//  Created by hyk on 6/27/24.
//

import Foundation

struct TodoModel: Codable {
    var category: String = ""
    var content: String = ""
    var planedDt: String = ""
    
    var params: [String: Any] {
        return [
            "category": category,
            "content": content,
            "planedDt": planedDt
        ]
    }
}


struct TodoResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: [TodoData]?
}

struct TodoData: Codable {
    var todoId: Int = 0
    var content: String = ""
    var planedDt: String = ""
    var isChecked: Bool = false
}

struct CategoryResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: CategoryData = CategoryData()
}

struct CategoryData: Codable {
    var category: [String] = []
}
