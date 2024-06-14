//
//  PageRequest.swift
//  babya
//
//  Created by dgsw8th61 on 6/14/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct PageRequest : Encodable {
    let page : Int
    let size : Int
}
