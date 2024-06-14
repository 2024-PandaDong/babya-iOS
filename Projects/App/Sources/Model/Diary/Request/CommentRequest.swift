//
//  CommentRequest.swift
//  babya
//
//  Created by dgsw8th61 on 6/14/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct CommentRequest : Encodable{
    let comment : String
    let parentCommentId : Int
    let diaryId : String
}
