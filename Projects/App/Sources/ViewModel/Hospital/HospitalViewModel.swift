import Foundation
import Alamofire
import CoreLocation
import MapKit

class HospitalViewModel: ObservableObject {
    @Published var model = HospitalResponse()
    @Published var places: [Place] = []

    static let shared = HospitalViewModel()

    func getKakaoRestAPIKey() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String
    }
    
    func getHospital(latitude: Double, longitude: Double, keyword: String) {
        guard let apiKey = getKakaoRestAPIKey() else {
            print("Failed to retrieve API key from Info.plist")
            return
        }

        let urlString = "https://dapi.kakao.com/v2/local/search/keyword.json"
        let keyword = keyword
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
                    self.model = data
                    self.convertDocumentsToPlaces()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    private func convertDocumentsToPlaces() {
        places = model.documents?.compactMap { hospital in
            if let latitude = Double(hospital.y ?? ""), let longitude = Double(hospital.x ?? ""), ((hospital.category_name?.contains("병원")) != nil) {
                return Place(
                    location: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                    name: hospital.place_name ?? "알 수 없음"
                )
            }
            return nil
        } ?? []
    }
}
