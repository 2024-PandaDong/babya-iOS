public func codeConverter(code: String) -> Int {
    var location = ""

    // 모든 지역 코드를 확인
    for local in LocalCode.allCases {
        // 코드에 지역 이름(local.name)이 포함되어 있는지 확인
        if code.contains(local.name) {
            location.append("\(local.rawValue)") // 해당 지역의 코드 추가
            
            // 지역 이름을 제거한 새로운 코드 문자열 생성
            let newCode = code.replacingOccurrences(of: local.name, with: "")
            
            // 지역 내 군/구 순회하면서 해당하는 군/구의 인덱스를 찾음
            for country in local.country {
                if newCode.contains(country) {
                    if let indexValue = indexConvert(local.country)[country] {
                        location.append("\(indexValue)") // 군/구의 인덱스 추가
                    }
                }
            }
        }
    }

    return Int(location.prefix(6)) ?? 0 // 반환값이 nil일 경우 0 반환
}

// 각 군/구에 대해 고유한 인덱스를 부여하는 함수
private func indexConvert(_ list: [String]) -> [String: Int] {
    var locationIndex: [String: Int] = [:]
    var index = 10 // 인덱스 값을 10부터 시작

    for country in list {
        locationIndex[country] = index
        
        index += 10 // 일반적인 경우에는 10씩 증가
    }

    return locationIndex
}
