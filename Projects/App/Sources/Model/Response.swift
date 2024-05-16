//
//  baseResponse.swift
//  babya
//
//  Created by dgsw8th61 on 5/9/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct Response<T:Decodable> : Decodable {
    let status : Int
    let message : String
    let data : T?
}

struct ErrorResponse: Decodable {
    let status: Int
    let code: String
    let message: String
}
