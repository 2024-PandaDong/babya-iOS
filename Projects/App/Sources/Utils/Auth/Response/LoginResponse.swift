//
//  LoginResponse.swift
//  babya
//
//  Created by dgsw8th61 on 5/9/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct LoginResponse : Decodable {
    let accessToken : String
    let refreshToken : String
}
