//
//  CompanyDetailResponse.swift
//  babya
//
//  Created by dgsw8th61 on 9/12/24.
//

import Foundation

struct CompanyDetailResponse: Decodable,Hashable {
    let name: String
    let link: String
    let description: String
    let mtrLvPeriod: Int
    let mtrLvSalary: Int
    let mtrLvIsSalary: String
    let mtrSupMoney: Int
    let mtrSupCondition: String
    let telComIsCan: String
    let telComTime: Int
    let telComDays: Int
    let subsdType: String
    let subsdMoney: Int
    let minSalary: Int
    let maxSalary: Int
    let avgSalary: Int
    let salaryYear: Int
    let femalePeople: Int
    let malePeople: Int
    let ceo: String
    let tel: String
    let address: String
    let historyYear: String
    let businessContent: String
    let companyType: String
    let businessType: String?
    let contentImg: String?
}
