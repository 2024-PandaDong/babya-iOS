//
//  ProfileViewModel.swift
//  babya
//
//  Created by hyk on 6/23/24.
//

import Foundation
import Alamofire
import UIKit

class ProfileViewModel: ObservableObject {
    @Published var model = ProfileModel()
    @Published var profileModifyModel = ProfileModifyModel()
    @Published var profileImageRequest = ProfileImageRequest()
    @Published var myRegion = RegionModel()
    
    static let shared = ProfileViewModel()
    
    func imageUpload(image: UIImage) {
        let headers: HTTPHeaders = [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .contentType("multipart/form-data")
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.jpegData(compressionQuality: 0.1) {
                multipartFormData.append(imageData, withName: "file", fileName: "image", mimeType: "image/jpeg")
            }
        }, to: "\(ApiContent.url)/upload", method: .post, headers: headers)
        .responseDecodable(of: UploadResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.profileImageRequest.imgUrl = data.data
                print("이미지url: \(self.profileImageRequest.imgUrl)")
                print("status code: \(response.response?.statusCode)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func patchProfileImage() {
        var params: [String: String] {
            return [
                "imgUrl": self.profileImageRequest.imgUrl
            ]
        }
        
        AF.request("\(ApiContent.url)/member", method: .patch, parameters: params,encoding: JSONEncoding.default, interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
            .responseJSON { json in
                print(json)
            }
    }
    
    func patchProfile(completion: @escaping () -> ()) {
        AF.request("\(ApiContent.url)/member/profile", method: .patch, parameters: profileModifyModel.params, encoding: JSONEncoding.default,  interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
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
}
