import Foundation

struct SignUpModel: Codable {
    var email: String = ""
    var pw: String = ""
    var nickName: String = ""
    var marriedDt: String = ""
    var pregnancyDt: String = ""
    var birthDt: String = ""
    var locationCode: String = ""
    var verifyCode: String = ""
    var childList: [Child] = []
    var birthList: [Child] = []
    var isPregnant: Bool = false
    var hasChild: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case email, pw, nickName, marriedDt, pregnancyDt, birthDt, locationCode, verifyCode, childList, birthList, isPregnant, hasChild
    }
    
    var params: [String: Any] {
        // `childList`와 `birthList`를 Dictionary로 변환
        let childListDicts = childList.map { ["name": $0.name, "isBirth": $0.isBirth] }
        let birthListDicts = birthList.map { ["name": $0.name, "isBirth": $0.isBirth] }
        
        var combinedList = childListDicts
        combinedList.append(contentsOf: birthListDicts)
        
        return [
            "email": email,
            "pw": pw,
            "nickName": nickName,
            "marriedDt": marriedDt,
            "pregnancyDt": pregnancyDt,
            "birthDt": birthDt,
            "locationCode": locationCode,
            "pushToken" : "",
            "verifyCode": verifyCode,
            "childList": combinedList
        ]
    }
}

struct Child: Codable, Identifiable {
    var id = UUID()
    var name: String
    var isBirth: Bool
}

struct PersonModel {
    var isBoxClicked: Bool = false
    var personalDataLabel: String = ""
}

struct ResponseModel: Codable {
    var status: Int
    var message: String
    var data: DataModel?
}

struct DataModel: Codable {
    var accessToken: String
    var refreshToken: String
}
