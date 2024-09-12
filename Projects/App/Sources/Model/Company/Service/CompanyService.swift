//
//  CompanyService.swift
//  babya
//
//  Created by dgsw8th61 on 9/11/24.
//

import Foundation
import SwiftUI

protocol CompanyService {
    func getCompany(pageRequest: PageRequest) async throws ->  Response<[CompanyResponse]>
    func getDetailCompany(Id: Int) async throws ->  Response<[CompanyDetailResponse]>
}
