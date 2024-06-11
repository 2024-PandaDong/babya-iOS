//
//  DiaryRequest.swift
//  babya
//
//  Created by dgsw8th61 on 6/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct DiaryRequest : Encodable{
    let title : String
    let content : String
    let pregnancyWeeks : Int
    let weight : Int
    let systolicPressure : Int
    let diastolicPressure : Int
    let nextAppointment : String
    let emoji : String
    let fetusComment : String
    let memo : String
    let isPublic : Bool
    let url : [String]
}
