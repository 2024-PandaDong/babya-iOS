//
//  PolicyModel.swift
//  babya
//
//  Created by hyk on 9/9/24.
//

import Foundation

struct PolicyListModel: Codable {
    let policyId: Int
    let title: String
    let editDate: String?
}

struct PolicyDetailModel: Codable {
    var title: String = ""
    var content: String = ""
    var editDate: String = ""
    var link: String = ""
}
