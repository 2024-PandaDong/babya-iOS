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
    @Published var diaryList = [DiaryResponse]()
    @Published var comment = [CommentResponse]()
    @Published var diarycount : Int = 0
    @Published var commentcount : Int = 0
    private var userEmail : String = "email"
    
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
            print("내 다이어리조회")
            diaryList = []
            diarycount = 0
            userEmail = email
            let response = try await diaryService.getDiary(pageRequest: pageRequest, email: email)
            print("페이지 : \(pageRequest.page) 사이즈 : \(pageRequest.size) 이메일 : \(email)")
            print(response)
            if let data = response.data {
                  diaryList = data.compactMap { $0 }
                  diarycount = data.count
              } else {
                  diaryList = []
                  diarycount = 0
              }
            
        } catch {
            print(error)
        }
    }
    
    func getNDiary(pageRequest : PageRequest,email : String) async {
        do {
            print("내 NN다이어리조회")
            diaryList = []
            diarycount = 0
            userEmail = email
            let response = try await diaryService.getDiary(pageRequest: pageRequest, email: email)
            print("페이지 : \(pageRequest.page) 사이즈 : \(pageRequest.size) 이메일 : \(email)")
            print(response)
            if let data = response.data {
                diaryList = data.compactMap { $0.isPublic == "N" ? $0 : nil  }
                diarycount = diaryList.count
              } else {
                  diaryList = []
                  diarycount = 0
              }
            
        } catch {
            print(error)
        }
    }
    
    func getListDiary(pageRequest : PageRequest) async {
        do {
            print("전체 다이어리 조회")
            diaryList = []
            diarycount = 0
            let response = try await diaryService.getListDiary(pageRequest: pageRequest)
            print(response)
            if let data = response.data {
                  diaryList = data.compactMap { $0 }
                  diarycount = data.count
              } else {
                  diaryList = []
                  diarycount = 0
              }
            
        } catch {
            print(error)
        }
    }
    func fetchListDiary(pageRequest : PageRequest) async {
        do {
            let response = try await diaryService.getListDiary(pageRequest: pageRequest)
            print(response)
            if let data = response.data {
                diaryList.append(contentsOf: data)
                diarycount += data.count
                print("diarycount   ::  \(diarycount)")
              } else {
                  diaryList = []
                  diarycount = 0
              }
        } catch {
            print(error)
        }
    }
    
    func fetchDiary(pageRequest : PageRequest) async {
        do {
            let response = try await diaryService.getDiary(pageRequest: pageRequest, email: userEmail)
            print(response)
            if let data = response.data {
                diaryList.append(contentsOf: data)
                diarycount += data.count
                print("diarycount   ::  \(diarycount)")
              } else {
                  diaryList = []
                  diarycount = 0
              }
        } catch {
            print(error)
        }
    }
    
    func getCommentDiary(pageRequest : PageRequest, id : Int) async {
        do {
            let response = try await diaryService.getCommentDiary(pageRequest: pageRequest, diaryId: id)
            print("다이어리 댓글댁슬~~~~~~~~~~~~~~")
            print(response)
            comment = response.data ?? []
            commentcount = comment.count
        } catch {
            print(error)
        }
    }
}
