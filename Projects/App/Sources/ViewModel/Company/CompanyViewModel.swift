//
//  CompanyViewModel.swift
//  babya
//
//  Created by dgsw8th61 on 9/11/24.
//

import Foundation
import SwiftUI
import Alamofire

class CompanyViewModel: ObservableObject {
    private let companyService: CompanyService
    @Published var companyList = [CompanyResponse]()
    @Published var companyInfo: CompanyDetailResponse?
    
    init(companyService: CompanyService) {
        self.companyService = companyService
    }
    
    func getCompany(pageRequest: PageRequest) async {
        do {
            let response = try await companyService.getCompany(pageRequest: pageRequest)
            if let data = response.data {
                DispatchQueue.main.async {
                    self.companyList = data
                }
            } else {
                DispatchQueue.main.async {
                    self.companyList = []
                }
            }
            
        } catch {
            print(error)
        }
    }

    
    func detailCompany(Id: Int) async {
        do {
            let response = try await companyService.getDetailCompany(Id: Id)
            print(response)
            if let data = response.data {
                DispatchQueue.main.async {
                    self.companyInfo = data
                }
            } else {
                DispatchQueue.main.async {
                    self.companyInfo = nil
                }
            }

        } catch {
            print(error)
        }
    }
}

