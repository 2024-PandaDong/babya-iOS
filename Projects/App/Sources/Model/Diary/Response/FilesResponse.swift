//
//  filesResponse.swift
//  babya
//
//  Created by dgsw8th61 on 6/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation

struct FilesResponse: Decodable{
    let fileId : Int
    let name: String
    let size: Int
    let `extension`: String
    let url: String
}
