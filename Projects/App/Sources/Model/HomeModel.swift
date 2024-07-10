//
//  HomeModel.swift
//  babya
//
//  Created by hyk on 6/26/24.
//

import Foundation

struct HomeModel: Codable {
    
}

struct BannerResponse: Codable {
    var status: Int = 0
    var message: String = ""
    var data: [BannerData] = []
}

struct BannerData: Codable {
    var image: BannerImage? = nil
    var source: String = ""
    var subTitle: String = ""
    var url: String = ""
}

struct BannerImage: Codable {
    var fileId: Int = 0
    var name: String = ""
    var size: Int = 0
    var `extension`: String = ""
    var url: String = ""
}
