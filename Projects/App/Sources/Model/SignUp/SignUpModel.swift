import Foundation

struct SignUpModel: Codable {
    var email: String = ""
    var pw1: String = ""
    var pw2: String = ""
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
        case email, pw1, nickName, marriedDt, pregnancyDt, birthDt, locationCode, verifyCode, childList, birthList, isPregnant, hasChild
    }
    
    var params: [String: Any] {
        let childListDicts = childList.map { ["name": $0.name, "isBirth": $0.isBirth] }
        let birthListDicts = birthList.map { ["name": $0.name, "isBirth": $0.isBirth] }
        
        var combinedList = childListDicts
        combinedList.append(contentsOf: birthListDicts)
        
        return [
            "email": email,
            "pw": pw1,
            "nickName": nickName,
            "marriedDt": marriedDt,
            "pregnancyDt": pregnancyDt,
            "birthDt": birthDt,
            "locationCode": locationCode,
            "pushToken" : "",
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
