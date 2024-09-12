//
//  EmailTextField.swift
//  SignUp-Narsha
//
//  Created by dgsw8th32 on 4/17/24.
//

import SwiftUI
import Alamofire

struct EmailTextFields: View {
    @State var isClicked: Bool = false
    @Binding var email: String
    @Binding var verifyCode: String
    @Binding var isAvailable: Bool
    @Binding var isVerified: Bool
    let action1: () -> Void
    let action2: () -> Void
    let action3: () -> Void
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, maxHeight: 55)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.LineAlternative)
                    
                    HStack(alignment: .center) {
                        VStack {
                            TextField("", text: $email, prompt: Text("email").font(.system(size: 16, weight: .semibold)))
                                .frame(width: 235)
                                .tint(Color.PrimaryNormal)
                                .textInputAutocapitalization(.never)
                                .onSubmit {
                                    action1()
                                    print(email)
                                    print(isAvailable)
                                }
                        }
                        
                        Button(action: {
                            withAnimation {
                                isClicked = true
                            }
                            action2()
                        }, label: {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 55, height: 30)
                                .foregroundStyle(isAvailable ? Color.PrimaryNormal : .ComponentMaterialDimmer)
                                .overlay {
                                    Text("인증")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 15, weight: .bold))
                                }
                        })
                        .disabled(isAvailable ? false : true)
                    }
                }
            
            if isClicked {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.LineAlternative)
                        
                        HStack(alignment: .center) {
                            VStack {
                                TextField("", text: $verifyCode, prompt: Text("인증번호를 입력해주세요.").font(.system(size: 16, weight: .semibold)))
                                    .frame(width: 230)
                                    .tint(Color.PrimaryNormal)
                                    .textInputAutocapitalization(.never)
                            }
                            
                            Button(action: {
                                action3()
                            }, label: {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 55, height: 30)
                                    .foregroundStyle(!isVerified ? Color.PrimaryNormal : .ComponentMaterialDimmer)
                                    .overlay {
                                        Text("인증")
                                            .foregroundStyle(.white)
                                            .font(.system(size: 15, weight: .bold))
                                    }
                            })
                            .disabled(isVerified ? true : false)
                        }
                    }
                    .padding(.vertical, 10)
            }
        }
    }
}

#Preview {
    EmailTextFields(email: .constant(""), verifyCode: .constant(""), isAvailable: .constant(false), isVerified: .constant(false), action1: {}, action2: {}, action3: {})
        .padding(.horizontal, 30)
}
