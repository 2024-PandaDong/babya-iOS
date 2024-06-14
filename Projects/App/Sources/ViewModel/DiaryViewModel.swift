//
//  DiaryViewModel.swift
//  babya
//
//  Created by dgsw8th61 on 6/13/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire

@MainActor
class DiaryViewModel: ObservableObject {
    private let diaryService: DiaryService
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    func diary(content : DiaryRequest) async {
            do {
                let response = try await diaryService.diary(request: content)
                print(response)
            } catch {
                print(error)
                
            }
        }
}
