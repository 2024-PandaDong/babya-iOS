//
//  NoticeBoardDetailViewModel.swift
//  babya
//
//  Created by hyk on 6/12/24.
//

import Foundation
import Alamofire

class NoticeBoardDetailViewModel: ObservableObject {
    private let noticeBoardService: NoticeBoardService
    @Published var postListModel = PostListResponse()
    @Published var model = NoticeBoardDetailModel()
    @Published var comment = [CommentResponse]()
    @Published var subComment = [SubCommentResponse]()
    @Published var diarycount: Int = 0
    @Published var commentCount: Int = 0
    @Published var subCommentCount: Int = 0
    @Published var Load: Bool = false
    var commentIdList: [Int] = []

    init(noticeBoardService: NoticeBoardService) {
        self.noticeBoardService = noticeBoardService
    }

    func getPostDetail(postId: Int) {
        AF.request("\(ApiContent.url)/post/\(postId)", method: .get, headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("*/*")])
            .responseDecodable(of: NoticeBoardDetailModel.self) { response in
                switch response.result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.model = data
                    }
                    print(postId)
                case .failure(let error):
                    if let data = response.data {
                        print("Response data: \(String(data: data, encoding: .utf8) ?? "Cannot decode data")")
                    }
                    print("Decoding error: \(error)")
                }
            }
    }

    func getCommentPost(pageRequest: PageRequest, id: Int) async {
        do {
            let response = try await noticeBoardService.getCommentPost(pageRequest: pageRequest, postId: id)
            print(response)
            DispatchQueue.main.async {
                self.comment = response.data ?? []
                self.commentCount = self.comment.count
                self.commentIdList = self.comment.map { Int($0.commentId) }
                print("리스트 \(self.commentIdList)")
            }

            await withTaskGroup(of: Void.self) { taskGroup in
                for comment in self.comment where comment.subCommentCnt > 0 {
                    taskGroup.addTask {
                        await self.getSubCommentPost(pageRequest: pageRequest, parentId: comment.commentId)
                    }
                }
            }
            DispatchQueue.main.async {
                self.Load = true
            }
        } catch {
            print(error)
        }
    }

    func getSubCommentPost(pageRequest: PageRequest, parentId: Int) async {
        do {
            let response = try await noticeBoardService.getPostSubComment(pageRequest: pageRequest, parentId: parentId)
            DispatchQueue.main.async {
                if let data = response.data {
                    self.subComment.append(contentsOf: data)
                    self.subCommentCount += data.count
                } else {
                    self.subComment = []
                    self.subCommentCount = 0
                }
                print("대댓글 수 : \(self.subCommentCount)")
                print("대댓글 리스트 : \(self.subComment)")
                print(response)
            }
        } catch {
            print(error)
        }
    }

    func postComment(comment: String, postId: Int, parentCommentId: Int) async {
        do {
            let response = try await noticeBoardService.postCommentPost(request: PostCommentRequest(comment: comment, parentCommentId: parentCommentId, postId: postId))
            print(response)
        } catch {
            print(error)
        }
    }
}
