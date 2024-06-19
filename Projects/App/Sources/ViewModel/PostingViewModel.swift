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
    
    func post() {
        AF.request("\(ApiContent.url)/post", method: .post, parameters: model.params)
            .response { response in
                switch response.result {
                case .success:
                    print("\(String(describing: response.response?.statusCode))")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

    func imageUpload(image: Image) {
        AF.upload(multipartFormData: { multipartFormData in
            
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                multipartFormData.append(imageData, withName: "file")
            }
            
        }, to: "\(ApiContent.url)/upload")
        .validate()
        .response { response in
            switch response.result {
            case.success(let data):
                print("\(String(describing: data))")
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var isAvailable: Bool {
        get {
            return !model.category.isEmpty && !model.title.isEmpty && !model.content.isEmpty
        }
    }
}
