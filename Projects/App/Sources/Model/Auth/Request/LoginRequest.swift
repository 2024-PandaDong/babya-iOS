//
//  LoginRequest.swift
//  babya
//
//  Created by dgsw8th61 on 5/9/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct LoginRequest : Encodable {
    let email: String
    let pw: String
}
