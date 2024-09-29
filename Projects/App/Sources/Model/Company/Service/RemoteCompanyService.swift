//
//  RemoteCompanyService.swift
//  babya
//
//  Created by dgsw8th61 on 9/11/24.
//

import Foundation
import Alamofire
import SwiftUI

final class RemoteCompanyService : CompanyService{
    func getDetailCompany(Id: Int) async throws -> Response<CompanyDetailResponse> {
        let url = "/company/\(Id)"
        return try await withCheckedThrowingContinuation { continuation in
            AF.request( ApiContent.url + url, method: .get,interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
                .responseDecodable(of: Response<CompanyDetailResponse>.self) { response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func getCompany(pageRequest: PageRequest) async throws -> Response<[CompanyResponse]> {
        let url = "/company?page=\(pageRequest.page)&size=\(pageRequest.size)"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request( ApiContent.url + url, method: .get,interceptor: MyRequestInterceptor(authService: RemoteAuthService()))
                .responseJSON { json in
                    print(json)
                }
                .responseDecodable(of: Response<[CompanyResponse]>.self) { response in
                    switch response.result {
                    case .success(let responseData):
                        continuation.resume(returning: responseData)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
