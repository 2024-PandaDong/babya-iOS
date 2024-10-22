//
//  SignUpViewModel.swift
//  babya
//
//  Created by dgsw8th32 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import Alamofire

class SignUpViewModel: ObservableObject {
    @Published var model = SignUpModel()
    @Published var personalModel: [PersonModel] = []
    @Published var isEmailAvailable = false
    @Published var hasOverSixLetter = false
    @Published var hasUnderTwentyLetter = false
    @Published var hasOneUppercaseChar = false
    @Published var hasSpecialChar = false
    @Published var isPwAvailable = false
    @Published var isEmailVerified = false
    @Published var selectedState: LocalCode? = .none
    @Published var selectedDistrict: String = ""
    @Published var familyType = 0
    @Published var rootActive: Bool = false
    
    func calculateWidth(for text: String) -> CGFloat {
        return CGFloat(text.count * 10 + 30)
    }

    var isFirstSignUpAvailable: Bool {
        get {
            return personalModel[0].isBoxClicked && personalModel[1].isBoxClicked && personalModel[2].isBoxClicked
        }
    }
    
    var isSecondSignUpAvailable: Bool {
        get {
            return isEmailVerified && !model.pw1.isEmpty && !model.pw2.isEmpty && model.pw1 == model.pw2
        }
    }

    var isThirdSignUpAvailable: Bool {
        get {
            return !model.nickName.isEmpty && !model.locationCode.isEmpty
        }
    }
    
    var isFifthSignUpAvailable: Bool {
        get {
            var isAvailable = false
            
            if self.familyType == 2 {
                isAvailable = model.pregnancyDt != nil && !model.birthList.isEmpty
            } else if self.familyType == 3 {
                isAvailable = !model.childList.isEmpty
            } else if self.familyType == 4 {
                isAvailable = model.pregnancyDt != nil && !model.birthList.isEmpty && !model.childList.isEmpty
            }
            
            return isAvailable
        }
    }

    
    init() {
        personalModel = [
            PersonModel(personalDataLabel: "개인정보 수집 이용 동의(필수)"),
            PersonModel(personalDataLabel: "서비스 이용 약관(필수)"),
            PersonModel(personalDataLabel: "개인정보 제 3자 정보 제공 동의(필수)"),
            PersonModel(personalDataLabel: "마켓팅 알림 수신 동의(선택)"),
            PersonModel(personalDataLabel: "광고성 정보 수신 동의(선택)"),
        ]
    }
    
    var totalAccept: Bool {
        get {
            return self.checkBoolList()
        }
        set {
            self.setAll()
        }
    }
    
    func toggleTotalAccept() {
        totalAccept.toggle()
    }
    
    
    func getClickedSelection(_ index: Int) {
        self.personalModel[index].isBoxClicked.toggle()
    }
    
    func setAll() {
        if !checkBoolList() {
            self.personalModel.indices.forEach {
                self.personalModel[$0].isBoxClicked = false
            }
        }
        else {
            self.personalModel.indices.forEach {
                self.personalModel[$0].isBoxClicked = true
            }
        }
        
    }
    
    
    func checkBoolList() -> Bool {
        if (self.personalModel.indices.filter{self.personalModel[$0].isBoxClicked==false}.count <= 0) {
            return false
        }
        else {
            return true
        }
        
        
    }
    
    
    func validateEmail() {
        let email = model.email
        
        let specialChar = CharacterSet(charactersIn: "@")
        if email.rangeOfCharacter(from: specialChar) != nil && email != "" {
            isEmailAvailable = true
        } else {
            isEmailAvailable = false
        }
    }
    
    func sendVerifyCode() {
        let email = model.email
        AF.request("\(ApiContent.url)/auth/email-send", method: .post, parameters: ["email" : email])
            .validate()
            .responseJSON { json in
                print(json)
            }
            .response { response in
                switch response.result {
                case .success:
                    if let statusCode = response.response?.statusCode, statusCode == 200 {
                        print("이메일 발송 성공")
                    }
                case .failure(let error):
                    print("요청 실패: \(error.localizedDescription)")
                }
            }
    }
    
    func verifyCode() {
        let email = model.email
        let code = model.verifyCode
        
        AF.request("\(ApiContent.url)/auth/email-verify", method: .post, parameters: ["email" : email, "code" : code])
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    if let statusCode = response.response?.statusCode, statusCode == 200 {
                        self.isEmailVerified.toggle()
                        print("이메일 인증 성공")
                    }
                case .failure(let error):
                    print("인증 실패: \(error.localizedDescription)")
                }
            }
    }
    
    func validatePassword() {
        let password = model.pw1
        
        hasOverSixLetter = password.count >= 6
        
        hasUnderTwentyLetter = password.count <= 20
        
        hasOneUppercaseChar = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>?")
        hasSpecialChar = password.rangeOfCharacter(from: specialCharacterSet) != nil
        
        isPwAvailable = hasOverSixLetter && hasUnderTwentyLetter && hasOneUppercaseChar && hasSpecialChar
    }
    
    func signUp() {
        AF.request("\(ApiContent.url)/auth/join", method: .post, parameters: model.params, encoding: JSONEncoding.default)
            .responseDecodable(of: ResponseModel.self) { response in
                self.rootActive = false
                print(response)
            }
    }
}
