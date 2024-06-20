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
    @Published var success: Bool = false
    
    init(diaryService: DiaryService) {
        self.diaryService = diaryService
    }
    func diary(content : DiaryRequest) async {
            do {
                let response = try await diaryService.postDiary(request: content)
                print(response)
                print(content)
                if response.status == 201{
                    success = true
                }
            } catch {
                print(error)
            }
        }
    
    func getDiary(pageRequest : PageRequest,email : String) async {
        do {
            let response = try await diaryService.getDiary(pageRequest: pageRequest, email: email)
            print(response)
        } catch {
            print(error)
        }
    }
}
