//
//  QuizResponse.swift
//  babya
//
//  Created by dgsw8th61 on 7/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct QuizResponse : Decodable{
    let quizId: Int
    let title: String
    let quizCn: String
    let answer: String
    let regDt: String
}
