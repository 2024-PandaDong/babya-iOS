//
//  AuthService.swift
//  babya
//
//  Created by dgsw8th61 on 5/18/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

protocol AuthService {
    func login(email: String, password: String) async throws -> Response<LoginResponse>
}
