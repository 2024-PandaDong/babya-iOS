//
//  PostingModel.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import Foundation

struct PostingModel: Codable {
    var title: String = ""
    var content: String = ""
    var category: String = ""
    var file: [String] = .init()
    
    var params: [String: Any] {
        return [
            "title": title,
            "content": content,
            "category": category,
            "file": file
        ]
    }
}
