//
//  ProfileModel.swift
//  babya
//
//  Created by hyk on 6/23/24.
//

import Foundation

struct ProfileModel: Codable {
    var status: Int = 0
    var message: String = ""
    var data: MyData = MyData()
}

struct MyData: Codable {
    var nickname: String = ""
    var dDay: Int?
    var birthDt: String = ""
    var marriedYears: String = ""
    var children: [Childs?]?
    var profileImg: String?
}

struct Childs: Codable {
    var childId: Int = 0
    var name: String? = ""
    var birthName: String? = ""
    var type: String = ""
}

struct RegionModel: Codable {
    var status: Int = 0
    var message: String = ""
    var data: String = ""
}
