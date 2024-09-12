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
    var planedDt: Date = .now
    
    let dateFormatter = DateFormatter()
    
    init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    var params: [String: Any] {
        return [
            "category": category,
            "content": content,
            "planedDt": dateFormatter.string(from: planedDt)
        ]
    }
    
    enum CodingKeys: CodingKey {
        case category
        case content
        case planedDt
    }
}


struct TodoResponse: Codable {
    
    var status: Int = 0
    var message: String = ""
    var data: [TodoData] = []
}

struct TodoData: Codable, Hashable {
    var todoId: Int = 0
    var content: String = ""
    var planedDt: String = ""
    var isChecked: Bool = false
    var category: String = ""

    static func == (lhs: TodoData, rhs: TodoData) -> Bool {
        return lhs.todoId == rhs.todoId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(todoId)
    }
}

struct CategoryResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: CategoryData = CategoryData()
}

struct CategoryData: Codable {
    var category: [String] = []
}
