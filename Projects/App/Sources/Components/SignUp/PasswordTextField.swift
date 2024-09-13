//
//  PasswordTextField.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/18/24.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var password: String
    let prompt: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: .infinity, maxHeight: 55)
            .foregroundStyle(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.LineAlternative)
                
                HStack(alignment: .center) {
                    VStack {
                        SecureField("", text: $password, prompt: Text(prompt).font(.system(size: 16, weight: .semibold)))
                            .frame(width: 230)
                            .tint(Color.PrimaryNormal)
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
    }
}

#Preview {
    PasswordTextField(password: .constant(""), prompt: "비밀번호")
        .padding(.horizontal, 30)
}
