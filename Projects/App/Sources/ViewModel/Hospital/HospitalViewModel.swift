import Foundation
import Alamofire

class HospitalViewModel: ObservableObject {
    @Published var model = HospitalModel()
    
    static let shared = HospitalViewModel()
    
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
            .responseDecodable(of: HospitalModel.self) { response in
                switch response.result {
                case .success(let data):
                    self.model = data
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

}
