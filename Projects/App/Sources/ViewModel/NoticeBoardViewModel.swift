//
//  NoticeBoardViewModel.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import Foundation
import Alamofire

class NoticeBoardViewModel: ObservableObject {
    @Published var model = NoticeBoardModel()
    
    func getPosts() {
        AF.request("\(ApiContent.url)/post/list", method: .get)
            .responseDecodable(of: NoticeBoardModel.self) { response in
                switch response.result {
                case.success(let data):
                    self.model = data
                    
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
