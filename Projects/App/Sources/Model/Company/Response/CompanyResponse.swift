//
//  CompanyResponse.swift
//  babya
//
//  Created by dgsw8th61 on 9/11/24.
//

import Foundation

struct CompanyResponse: Decodable{
    let companyId: Int
    let name: String
    let link: String
    let intro: String
    let description: String
    let state: String
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
}
