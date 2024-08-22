//
//  PostCommentRequest.swift
//  babya
//
//  Created by hyk on 7/11/24.
//

import Foundation

struct PostCommentRequest : Encodable{
    let comment : String
    let parentCommentId : Int
    let postId : Int
}
