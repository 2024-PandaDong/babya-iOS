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
    func getDiary(request: PageRequest) async throws -> Response<DiaryResponse>
    func commentDiary(request:)
}
