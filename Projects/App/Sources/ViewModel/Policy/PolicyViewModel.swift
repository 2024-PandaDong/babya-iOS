//
//  PolicyViewModel.swift
//  babya
//
//  Created by hyk on 9/10/24.
//

import Foundation
import Alamofire

class PolicyViewModel: ObservableObject {
    @Published var model: [PolicyListModel] = .init()
    @Published var policyDetailmodel = PolicyDetailModel()
    @Published var selectedState: LocalCode? = .none
    @Published var selectedDistrict: String = ""
    @Published var regionCode = ""
    
    static let shared = PolicyViewModel()
    
    func calculateWidth(for text: String) -> CGFloat {
        return CGFloat(text.count * 10 + 30)
    }
    
    func getPolicyList(region: String, keyword: String) {
        model = []
        
        AF.request(
            "\(ApiContent.url)/policy?region=\(region)&keyword=\(keyword)",
            method: .get,
            encoding: JSONEncoding.default,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
            .responseDecodable(of: Response<[PolicyListModel]>.self) { response in
                switch response.result {
                case .success(let result):
                    guard let decodedData = result.data else { return }
                    
                    self.model = decodedData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func getPolicyDetail(index: Int) {
        AF.request(
            "\(ApiContent.url)/policy/\(index)",
            method: .get,
            interceptor: MyRequestInterceptor(authService: RemoteAuthService())
        )
            .responseDecodable(of: Response<PolicyDetailModel>.self) { response in
                switch response.result {
                case .success(let result):
                    guard let decodedData = result.data else { return }
                    
                    self.policyDetailmodel = decodedData
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
