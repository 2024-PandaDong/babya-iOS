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
    var dDay: String?
    var birthDt: String?
    var marriedYears: String?
    var children: [Childs?]?
    var profileImg: String?
}

struct Childs: Codable, Hashable {
    var childId: Int = 0
    var name: String?
    var birthName: String?
    var type: String = ""
}

struct RegionModel: Codable {
    var status: Int = 0
    var message: String = ""
    var data: String = ""
}

struct ProfileModifyModel: Codable {
    var nickName: String = ""
    var marriedDt: String = ""
    var pregnancyDt: String = ""
    var birthDt: String = ""
    var lc: String = ""
    
    var params: [String: Any] {
        return [
            "nickName": nickName,
            "marriedDt": marriedDt,
            "pregnancyDt": pregnancyDt,
            "birthDt": birthDt,
            "lc": lc,
        ]
    }
}

struct ProfileImageRequest: Codable {
    var imgUrl: String = ""
    
    var parmas: [String: Any] {
        return [
            "imgUrl": imgUrl
        ]
    }
}
