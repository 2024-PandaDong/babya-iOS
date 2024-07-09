//
//  DiaryService.swift
//  babya
//
//  Created by dgsw8th61 on 6/13/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

protocol DiaryService {
    func postDiary(request: DiaryRequest) async throws -> baseResponse
    func getDiary(pageRequest: PageRequest,email: String) async throws -> Response<[DiaryResponse]>
    func getCommentDiary(pageRequest: PageRequest, diaryId: Int) async throws -> Response<[CommentResponse]>
    func postCommentDiary(request: CommentRequest) async throws -> baseResponse
    func deleteCommentDiary(id: Int) async throws -> baseResponse
    func getDetailDiary(id: Int) async throws -> Response<DiaryResponse>
//    func getSubComment(pageRequest: PageRequest, parentId: Int) -> Response<[SubCommentResponse]>
    func getSubComment(pageRequest: PageRequest, parentId: Int) async throws -> Response<[SubCommentResponse]>
    func stausWeekDiary() async throws -> Response<DiaryWeekStausResponse>
    func getListDiary(pageRequest: PageRequest) async throws -> Response<[DiaryResponse]>
}
