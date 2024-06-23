//
//  UploadResponse.swift
//  babya
//
//  Created by hyk on 6/17/24.
//

import Foundation

struct UploadResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: String = ""
}
