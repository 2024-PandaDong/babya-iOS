//
//  RegionConverter.swift
//  babya
//
//  Created by hyk on 9/26/24.
//

import Foundation

public func regionConverter(code: String) {
    // 모든 지역(LocalCode)을 순회하며 해당 코드와 일치하는 군/구 값을 찾음
    for local in LocalCode.allCases {
        // 지역(LocalCode) 내 군/구 리스트에서 code와 일치하는 군/구(value)를 검색
        if let districtName = local.country.first(where: { $0.value == code })?.key {
            // 해당 지역을 selectedState로 설정
            PolicyViewModel.shared.selectedState = local
            ProfileViewModel.shared.selectedState = local
            // 일치하는 군/구의 이름을 selectedDistrict로 설정
            PolicyViewModel.shared.selectedDistrict = districtName
            ProfileViewModel.shared.selectedDistrict = districtName
            // regionCode는 일치하는 코드 값 그대로 설정
            PolicyViewModel.shared.regionCode = code
            ProfileViewModel.shared.regionCode = code
            break // 일치하는 항목을 찾았으면 루프 종료
        }
    }
}


