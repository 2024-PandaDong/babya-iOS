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
    @Published var subcomment = [SubCommentResponse]()
    @Published var diarycount : Int = 0
    @Published var commentcount : Int = 0
    @Published var subcommentcount : Int = 0
    @Published var Load : Bool = false
    @Published var imageUrl : String = ""
    var commentIdList : [Int] = []
    
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
            print("이메일 : \(email)")
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
            print("내 비공개 다이어리조회")
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
    }// Do : comment fetch 구현 페이징 처리 
    
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
    
    func getCommentDiary(pageRequest: PageRequest, id: Int) async {
        do {
            let response = try await diaryService.getCommentDiary(pageRequest: pageRequest, diaryId: id)
            print(response)
            self.comment = response.data ?? []
            self.commentcount = self.comment.count
            self.commentIdList = self.comment.map { Int($0.commentId) }
            print("리스트 \(self.commentIdList)")
            
            await withTaskGroup(of: Void.self) { taskGroup in
                for comment in self.comment where comment.subCommentCnt > 0 {
                    taskGroup.addTask {
                        await self.getSubCommentDiary(pageRequest: pageRequest, parentId: comment.commentId)
                    }
                }
            }
            self.Load = true
        } catch {
            print(error)
        }
    }
    
    func getSubCommentDiary(pageRequest: PageRequest, parentId: Int) async {
        do {
            let response = try await diaryService.getSubComment(pageRequest: pageRequest, parentId: parentId)
            if let data = response.data {
                //                subcomment = data.compactMap { $0 }
                subcomment.append(contentsOf: data)
//                subcomment.insert(contentsOf: data, at: 0)
                subcommentcount += data.count
            } else {
                subcomment = []
                subcommentcount = 0
            }
            print("대댓글 수 : \(subcommentcount)")
            print("대댓글 리스트 : \(subcomment)")
            print(response)
        }catch{
            print(error)
        }
    }
    func postComment(comment: String, diaryId: Int, parentCommentId : Int) async {
        do{
            let response = try await diaryService.postCommentDiary(request: CommentRequest(comment: comment,
                                                                                           parentCommentId: parentCommentId,
                                                                                           diaryId: diaryId))
            print(response)
        }catch{
            print(error)
        }
    }
    
    func upload(image : UIImage) async {
        do {
            let response = try await diaryService.upload(image: image)
            imageUrl = response.data ?? ""
            print(response)
        }catch{
            print(error)
        }
    }
}
