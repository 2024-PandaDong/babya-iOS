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
    @Published var myRegion = RegionModel()
    @Published var myPost = MyPostResponse()
    @Published var myDiary = MyDiaryResponse()
    
    static let shared = ProfileViewModel()
    
    func getMyProfile() {
        let url = "\(ApiContent.url)/member/profile/my"
        let headers: HTTPHeaders = [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: ProfileModel.self) { response in
                switch response.result {
                case .success(let data):
                    self.model = data
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func getMyRegion() {
        AF.request(
            "\(ApiContent.url)/member/lc",
            method: .get,
            headers: [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
            ]
        )
        .responseDecodable(of: RegionModel.self) { response in
            switch response.result {
            case .success(let data):
                self.myRegion = data
                regionConverter(code: "\(data.data)")
                print("나의 지역: \(data.data)")
                PolicyViewModel.shared.getPolicyList(region: "\(data.data)", keyword: "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func withdraw() {
        AF.request(
            "\(ApiContent.url)/member/withdraw",
            method: .delete,
            headers: [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
            ]
        )
        .responseJSON { json in
            print(json)
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
