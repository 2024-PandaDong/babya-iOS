//
//  RegionConverter.swift
//  babya
//
//  Created by hyk on 9/26/24.
//

import Foundation

public func regionConverter(code: String) {
    // selectedState를 설정할 수 있도록 각 지역 코드를 확인
    LocalCode.allCases.forEach { local in
        if code.prefix(4) == "\(local.rawValue)" {
            // 지역 코드에 해당하는 지역을 설정
            PolicyViewModel.shared.selectedState = local
            
            // 지역 코드에서 군/구 정보를 추출
            let districtCode = String(code.suffix(2)) // 마지막 2자리를 군/구 코드로 사용
            if let districtIndex = Int(districtCode) {
                let districtList = local.country
                
                // 인덱스 변환 후 selectedDistrict에 해당하는 군/구 설정
                let districtMapping = indexConvert(districtList)
                districtMapping.forEach { (districtName, index) in
                    if index == districtIndex {
                        PolicyViewModel.shared.selectedDistrict = districtName
                    }
                }
            }
        }
    }
}

// 기존의 indexConvert 함수를 활용해서 인덱스를 변환하는 방식 그대로 사용
private func indexConvert(_ list: [String]) -> [String: Int] {
    var location: [String: Int] = .init()
    var index = 10
    
    for country in list {
        location[country] = index
        index += 10
    }
    
    return location
}
