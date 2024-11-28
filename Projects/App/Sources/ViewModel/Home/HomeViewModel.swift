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
    @Published var hospitalResonse = HospitalResponse()
    
    static let shared = HomeViewModel()
    
    func getBanner(type: String) {
        let params: [String : Any] = [
            "type": type
        ]
        
        var urlComponents = URLComponents(string: "\(ApiContent.url)/banner/my")!
        urlComponents.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                
        guard let url = urlComponents.url else { return }
        
        AF.request(url, method: .get, encoding: URLEncoding.default, interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
            .responseDecodable(of: BannerResponse.self) { response in
                switch response.result {
                case .success(let data):
                    self.bannerResponse = data
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getKakaoRestAPIKey() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String
    }
    
    func getHospital(latitude: Double, longitude: Double) {
        guard let apiKey = getKakaoRestAPIKey() else {
            print("Failed to retrieve API key from Info.plist")
            return
        }

        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json"
        let keyword = "산부인과"
        let radius = 5000

        let parameters: [String: Any] = [
            "query": keyword,
            "x": longitude,
            "y": latitude,
            "radius": radius,
            "sort": "distance"
        ]

        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(apiKey)"
        ]

        AF.request(urlString, method: .get, parameters: parameters, headers: headers)
            .responseJSON { json in
                print(json)
            }
            .responseDecodable(of: HospitalResponse.self) { response in
                switch response.result {
                case .success(let data):
                    self.hospitalResonse = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
