//
//  HomeViewModel.swift
//  babya
//
//  Created by hyk on 6/26/24.
//

import Foundation
import Alamofire

class HomeViewModel: ObservableObject {
    @Published var model = HomeModel()
    @Published var bannerResponse: BannerResponse = BannerResponse()
    
    func getBanner(type: String) {
        let params: [String : Any] = [
            "type": type
        ]
        let headers: HTTPHeaders = [
            .authorization(bearerToken: LoginUserHashCache.shared.checkAccessToken() ?? LoginUserHashCache.accessToken),
            .accept("application/json")
        ]
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/banner/my")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                
        guard let url = urlComponents.url else { return }
        
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers)
            .responseJSON { json in
                print(json)
            }
            .responseDecodable(of: BannerResponse.self) { response in
                switch response.result {
                case .success(let data):
                    self.bannerResponse = data
                    print("Decoded response: \(data)")
                    
                case .failure(let error):
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
    }
}
