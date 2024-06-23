//
//  PostingViewModel.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

class PostingViewModel: ObservableObject {
    @Published var model = PostingModel()
    @Published var uploadResponse = UploadResponse()
    
    func post() {
        AF.request("\(ApiContent.url)/post", 
                   method: .post,
                   parameters: model.params,
                   encoding: JSONEncoding.default,
                   headers: [.authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken), .accept("*/*")])
            .responseJSON { json in
                print(json)
            }
            .response { response in
                switch response.result {
                case .success:
                    print("\(String(describing: response.response?.statusCode))")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

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
            print("response")
            switch response.result {
            case .success(let data):
                print(data.data)
                self.model.file.append( data.data )
                
                if let statusCode = response.response?.statusCode {
                    print("status code: \(statusCode)")
                }
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    print("status code: \(statusCode), error: \(error.localizedDescription)")
                }
            }
        }
    }

    
    var isAvailable: Bool {
        get {
            return !model.category.isEmpty && !model.title.isEmpty && !model.content.isEmpty
        }
    }
}
