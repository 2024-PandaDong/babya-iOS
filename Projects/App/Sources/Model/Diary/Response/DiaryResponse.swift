//
//  DiaryResponse.swift
//  babya
//
//  Created by dgsw8th61 on 6/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct DiaryResponse : Decodable{
    let diaryId : Int
    let title : String
    let content : String
    let pregnancyWeeks : Int
    let weight : String
    let systolicPressure : Int
    let diastolicPressure : Int
    let nextAppointment : String
    let emojiCode : String
    let fetusComment : String
    let memo : String
    let writtenDt : String
    let isPublic : String
    let files : [FilesResponse]
    let memberId : String
    let nickname : String
}
