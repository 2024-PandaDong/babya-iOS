//
//  NoticeBoardDetailModel.swift
//  babya
//
//  Created by hyk on 6/8/24.
//

import Foundation

struct NoticeBoardDetailModel {
    let status: Int = 0
    let message: String = ""
    var data: DataClass = DataClass()
}

struct DataClass {
    var postVO: PostVO = PostVO()
    var comments: [Comment] = []
}

struct Comment {
    var postCmtID: Int = 0
    var content: String = ""
    var createdAt: String = ""
    var member: Member = Member()
}

struct Member {
    var email: String = ""
    var nickName: String = ""
    var marriedDt: String = ""
    var pregnancyDt: String = ""
    var birthDt: String = ""
    var childCnt: Int = 0
    var lc: String = ""
    var recentConDt: String = ""
    var memberState: String = ""
    var answerDt: String = ""
    var createdAt: String = ""
}

struct PostVO {
    var post: Post = Post()
    var files: [File] = []
}

struct File {
    var fileID: Int = 0
    var name: String = ""
    var size: Int = 0
    var fileExtension: String = ""
    var url: String = ""
}

struct Post {
    var postID: Int = 0
    var title: String = ""
    var content: String = ""
    var category: String = ""
    var view: Int = 0
    var createdAt: String = ""
    var postState: String = ""
    var member: Member = Member()
}
