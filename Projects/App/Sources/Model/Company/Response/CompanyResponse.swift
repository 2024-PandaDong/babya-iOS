//
//  CompanyResponse.swift
//  babya
//
//  Created by dgsw8th61 on 9/11/24.
//

import Foundation

struct CompanyResponse: Decodable{
    let companyId: Int
    let companyName: String
    let address: String
    let logoImg: [String?]
}
