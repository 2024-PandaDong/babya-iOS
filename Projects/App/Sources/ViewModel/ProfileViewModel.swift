//
//  ProfileViewModel.swift
//  babya
//
//  Created by hyk on 6/23/24.
//

import Foundation
import Alamofire

class ProfileViewModel: ObservableObject {
    @Published var model = ProfileModel()
    @Published var myPost = MyPostResponse()
    @Published var myDiary = MyDiaryResponse()
    
    func getMyProfile() {
        let url = "\(ApiContent.url)/member/profile/my"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .get, headers: headers)
            .responseJSON { json in
                print(json)
            }
            .responseDecodable(of: ProfileModel.self) { response in
                switch response.result {
                case .success(let data):
                    self.model = data
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func getMyDiary(page: Int, size: Int) {
        let url = "\(ApiContent.url)/diary/my/profile"
        let params: [String : Any] = [
            "page" : page,
            "size" : size,
        ]
        let headers: HTTPHeaders = [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers)
            .responseDecodable(of: MyDiaryResponse.self) { response in
                switch response.result {
                case .success(let data):
                    self.myDiary = data
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func getMyPosts(page: Int, size: Int) {
        let url = "\(ApiContent.url)/post/my"
        let params: [String : Any] = [
            "page" : page,
            "size" : size,
        ]
        let headers: HTTPHeaders = [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers)
            .responseDecodable(of: MyPostResponse.self) { response in
                switch response.result {
                case .success(let data):
                    self.myPost = data
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}
