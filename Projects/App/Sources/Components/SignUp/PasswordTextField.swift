//
//  PasswordTextField.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/18/24.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String
    @Binding var isAvailable: Bool
    let action: () -> Void
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("비밀번호")
                .fontWeight(.bold)
            
            HStack {
                TextField("", text: $password, prompt: Text("비밀번호를 입력해주세요").font(.system(size: 14, weight: .semibold)))
                    .tint(.yellow)
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        action()
                        print(password)
                        print(isAvailable)
                    }
                
                Text(isAvailable ? "사용 가능" : "사용 불가능")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(isAvailable ? .green : .red)
            }
            
            Rectangle()
                .frame(width: 330, height: 1)
                .foregroundStyle(Color(red: 203/255, green: 203/255, blue: 203/255))
            
            Text("영문 대소문자, 특수문자, 숫자를 조합하여 6~20자로 입력해주세요")
                .font(.system(size: 11, weight: .ultraLight))
                .padding(.top, 10)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 5)
    }
}

#Preview {
    PasswordTextField(password: .constant(""), isAvailable: .constant(false)) {
        
    }
}
