//
//  CommentResponse.swift
//  babya
//
//  Created by dgsw8th61 on 6/14/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct CommentResponse : Decodable{
    let commentId : Int
    let content : String
    let createdAt : String
    let subCommentCnt : Int
    let memberId : String
    let profileImg : String
    let nickname : String
}
