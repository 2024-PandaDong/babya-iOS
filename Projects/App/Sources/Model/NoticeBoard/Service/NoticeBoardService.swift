//
//  NoticeBoardService.swift
//  babya
//
//  Created by hyk on 7/11/24.
//

import Foundation
import UIKit

protocol NoticeBoardService {
    func getCommentPost(pageRequest: PageRequest, postId: Int) async throws -> Response<[CommentResponse]>
    func postCommentPost(request: PostCommentRequest) async throws -> baseResponse
    func deleteCommentPost(id: Int) async throws -> baseResponse
    func getPostSubComment(pageRequest: PageRequest, parentId: Int) async throws -> Response<[SubCommentResponse]>
}
