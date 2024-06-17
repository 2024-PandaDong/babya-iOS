//
//  FirstSignUpView.swift
//  babya
//
//  Created by dgsw8th32 on 5/7/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct FirstSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(height: 120)
                    .foregroundStyle(.white)
                    .border(Color(red: 203/255, green: 203/255, blue: 203/255))
                    .overlay {
                        ZStack {
                            HStack {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Image(systemName: "arrow.left")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 22, weight: .semibold))
                                })
                                Spacer()
                            }
                            Text("회원가입")
                                .font(.system(size: 25, weight: .bold))
                        }
                        .padding(.horizontal)
                        .padding(.top, 45)
                    }
                
                ScrollView {
                    EmailTextFields(email: $viewModel.model.email, verifyCode: $viewModel.model.verifyCode, isAvailable: $viewModel.isEmailAvailable, isVerified: $viewModel.isEmailVerified, action1: viewModel.validateEmail, action2: viewModel.sendVerifyCode, action3: viewModel.verifyCode)
                        .padding(.top, 40)
                    
                    PasswordTextField(password: $viewModel.model.pw, isAvailable: $viewModel.isPwAvailable) {
                        viewModel.validatePassword()
                    }
                    
                    SignUpTextField(title: "이름", content: $viewModel.model.nickName, placeholder: "이름을 입력 해주세요") {
                        
                    }
                    
                    CustomDatePicker("생년월일", target: $viewModel.model.birthDt)
                    
                    LocationPicker(target: $viewModel.model.locationCode)
                }
                
                VStack {
                    NavigationLink() {
                       SecondSignUpView()
                            .environmentObject(viewModel)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 340, height: 50)
                            .foregroundStyle(viewModel.isFirstSignUpAvailable ? Color(red: 255/255, green: 203/255, blue: 41/255) : .gray)
                            .overlay {
                                Text("다음")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15, weight: .bold))
                            }
                    }
                    .padding(.bottom)
                    
//                    .disabled(!viewModel.isFirstSignUpAvailable)
                }
                .padding(.bottom, 30)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        FirstSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
