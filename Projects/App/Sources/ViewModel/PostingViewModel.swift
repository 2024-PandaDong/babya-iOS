//
//  PostingViewModel.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import Foundation
import Alamofire

class PostingViewModel: ObservableObject {
    @Published var model = PostingModel()
    
    func post() {
        AF.request("\(ApiContent.url)/post", method: .post, parameters: model.params)
            .response { response in
                switch response.result {
                case .success:
                    print("게시글 등록 성공")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
