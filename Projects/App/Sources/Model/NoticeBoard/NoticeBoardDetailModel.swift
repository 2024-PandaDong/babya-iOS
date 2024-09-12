//
//  NoticeBoardDetailModel.swift
//  babya
//
//  Created by hyk on 6/8/24.
//

import Foundation

struct NoticeBoardDetailModel: Codable {
    var status: Int = 0
    var message: String = ""
    var data: DataClass = DataClass()
}

struct DataClass: Codable {
    var postId: Int = 0
    var title: String = ""
    var content: String = ""
    var category: String = ""
    var view: Int = 0
    var commentCnt: Int = 0
    var createdAt: String = ""
    var files: [File]?
    var memberId: String = ""
    var profileImg: String?
    var nickname: String = ""
}

struct File: Codable {
    var fileId: Int = 0
    var name: String = ""
    var size: Int = 0
    var fileExtension = ""
    var url: String = ""
    
    enum CodingKeys: String, CodingKey {
            case fileId = "fileId"
            case name = "name"
            case size = "size"
            case fileExtension = "extension"
            case url = "url"
    }
}

struct PostCommentModel: Codable {
    var comment: String = ""
    var parentCommentId: Int = 0
    var postId: Int = 0
}

struct PostCommentResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: [CommentData] = []
}

struct CommentData: Codable {
    var commentId: Int = 0
    var content: String = ""
    var createdAt: String = ""
    var memberId: String = ""
    var nickname: String = ""
    var profileImg: String?
    var subCommentCnt: Int = 0
}


