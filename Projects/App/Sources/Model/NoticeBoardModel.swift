//
//  NoticeBoardModel.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import Foundation

struct NoticeBoardModel: Codable {
    var data : [Datum] = []
}

struct Datum: Codable {
    var title: String = ""
    var content: String = ""
}
