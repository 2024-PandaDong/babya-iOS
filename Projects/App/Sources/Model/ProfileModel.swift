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
    var age: Int = 0
    var marriedYears: String?
    var children: [Childs?]?
    var profileImg: String?
}

struct Childs: Codable {
    var childId: Int = 0
    var name: String = ""
    var birthName: String = ""
    var type: String = ""
}

struct MyDiaryResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: [MyDiaryResponseData] = []
}

struct MyDiaryResponseData: Codable {
    var id: Int = 0
    var title: String = ""
    var emoji: String = ""
    var writtenDt: String = ""
}

struct MyPostResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: [MyPostResponseData] = []
}

struct MyPostResponseData: Codable {
    var id: Int = 0
    var title: String = ""
    var createdAt: String = ""
}
