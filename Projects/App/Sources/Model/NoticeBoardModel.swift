//
//  NoticeBoardModel.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import Foundation

struct PostListResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: [Datum] = []
}

struct Datum: Codable {
    var postId: Int = 0
    var title: String = ""
    var content: String = ""
    var category: String = ""
    var view: Int = 0
    var commentCnt: Int = 0
    var createdAt: String = ""
    var memberId: String = ""
    var nickname: String = ""
}
