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
    @Published var profileModifyModel = ProfileModifyModel()
    @Published var myRegion = RegionModel()
    
    static let shared = ProfileViewModel()
    
    func patchProfile(completion: @escaping () -> ()) {
        AF.request("\(ApiContent.url)/member/profile", method: .patch, parameters: profileModifyModel.params, encoding: JSONEncoding.default,  interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
            .responseJSON { json in
                print(json)
            }
            .response { response in
                switch response.response?.statusCode {
                case 200:
                    completion()
                default:
                    print("실패")
                }
            }
    }
    
    func getMyProfile() {
        AF.request(
            "\(ApiContent.url)/member/profile/my",
            method: .get,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
        .responseJSON { json in
            print(json)
        }
            .responseDecodable(of: ProfileModel.self) { response in
                switch response.result {
                case .success(let data):
                    self.model = data
                    self.profileModifyModel.nickName = data.data.nickname
                    self.profileModifyModel.marriedDt = data.data.marriedYears ?? ""
                    self.profileModifyModel.birthDt = data.data.birthDt ?? ""
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func getMyRegion() {
        AF.request(
            "\(ApiContent.url)/member/lc",
            method: .get,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
        .responseJSON { json in
            print(json)
        }
        .responseDecodable(of: RegionModel.self) { response in
            switch response.result {
            case .success(let data):
                self.myRegion = data
                self.profileModifyModel.lc = data.data
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
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
        .responseJSON { json in
            print(json)
        }
    }
    
//    func getMyDiary(page: Int, size: Int) {
//        let url = "\(ApiContent.url)/diary/my/profile"
//        let params: [String : Any] = [
//            "page" : page,
//            "size" : size,
//        ]
//        let headers: HTTPHeaders = [
//            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
//            .accept("application/json")
//        ]
//        
//        AF.request(url, method: .get, parameters: params, headers: headers)
//            .responseDecodable(of: MyDiaryResponse.self) { response in
//                switch response.result {
//                case .success(let data):
//                    self.myDiary = data
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }
//    }
//    
//    func getMyPosts(page: Int, size: Int) {
//        let url = "\(ApiContent.url)/post/my"
//        let params: [String : Any] = [
//            "page" : page,
//            "size" : size,
//        ]
//        let headers: HTTPHeaders = [
//            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
//            .accept("application/json")
//        ]
//        
//        AF.request(url, method: .get, parameters: params, headers: headers)
//            .responseDecodable(of: MyPostResponse.self) { response in
//                switch response.result {
//                case .success(let data):
//                    self.myPost = data
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }
//    }
}
