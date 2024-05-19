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
            HStack {
                VStack(alignment: .leading) {
                    Text("이메일")
                        .fontWeight(.bold)
                    
                    HStack {
                        TextField("", text: $email, prompt: Text("이메일을 입력 해주세요").font(.system(size: 14, weight: .semibold)))
                            .tint(.yellow)
                            .textInputAutocapitalization(.never)
                            .onSubmit {
                                action1()
                                print(email)
                                print(isAvailable)
                        }
                        
                        Button(action: {
                            email = ""
                            isAvailable = false
                        }, label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 23, height: 19)
                                .foregroundStyle(.black)
                                .overlay {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 15, weight: .bold))
                                }
                        })
                    }
                    
                    Rectangle()
                        .frame(width: 250, height: 1)
                        .foregroundStyle(Color(red: 203/255, green: 203/255, blue: 203/255))
                }
                .padding(.leading, 30)
                
                Button(action: {
                    withAnimation {
                        isClicked = true
                    }
                    print("이메일 \(email)")
                    print("가능 \(isAvailable)")
                    action2()
                }, label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 90, height: 40)
                        .foregroundStyle(isAvailable ? Color(red: 255/255, green: 203/255, blue: 41/255) : .gray)
                        .overlay {
                            Text("이메일 인증")
                                .foregroundStyle(.white)
                                .font(.system(size: 15, weight: .bold))
                        }
                        .padding(.horizontal, 8)
                        .padding(.bottom, -20)
                })
                .disabled(isAvailable ? false : true)
            }
            .padding(.vertical, 5)
            
            if isClicked {
                HStack {
                    VStack {
                        TextField("", text: $verifyCode, prompt: Text("인증번호를 입력 해주세요").font(.system(size: 14, weight: .semibold)))
                            .tint(.yellow)
                            .textInputAutocapitalization(.never)
                        
                        Rectangle()
                            .frame(width: 250, height: 1)
                            .foregroundStyle(Color(red: 203/255, green: 203/255, blue: 203/255))
                    }
                    .padding(.leading, 30)
                    
                    Button(action: {
                        action3()
                        print(isVerified)
                    }, label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 90, height: 40)
                            .foregroundStyle(isVerified ? .green : .yellow)
                            .overlay {
                                Text(isVerified ? "인증완료" : "인증하기")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15, weight: .bold))
                            }
                            .padding(.horizontal, 8)
                            .padding(.bottom, 10)
                    })
                    .disabled(isVerified ? true : false)
                }
            }
        }
    }
}

#Preview {
    EmailTextFields(email: .constant(""), verifyCode: .constant(""), isAvailable: .constant(false), isVerified: .constant(false), action1: {}, action2: {}, action3: {})
}
