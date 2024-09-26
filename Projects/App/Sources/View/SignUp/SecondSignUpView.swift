//
//  SecondSignUpView.swift
//  babya
//
//  Created by dgsw8th32 on 5/7/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct SecondSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                
                Rectangle()
                    .frame(width: geometry.size.width / 3, height: 2)
                    .foregroundStyle(Color.PrimaryNormal)
                
                Group {
                    Text("이메일 & 비밀번호")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 50)
                    
                    Text("인증한 이메일로 로그인을 할 수 있어요.")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.vertical)
                    
                    EmailTextFields(email: $viewModel.model.email, verifyCode: $viewModel.model.verifyCode, isAvailable: $viewModel.isEmailAvailable, isVerified: $viewModel.isEmailVerified, action1: viewModel.validateEmail, action2: viewModel.sendVerifyCode, action3: viewModel.verifyCode)
                    
                    Divider()
                        .padding(.vertical, 15)
                    
                    PasswordTextField(password: $viewModel.model.pw1, prompt: "비밀번호")
                    PasswordTextField(password: $viewModel.model.pw2, prompt: "비밀번호 확인")
                        .padding(.vertical, 15)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: ThirdSignUpView().environmentObject(viewModel)) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(viewModel.isSecondSignUpAvailable ? Color.PrimaryNormal : .ComponentMaterialDimmer)
                        .overlay {
                            Text("다음으로")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                }
                .disabled(!viewModel.isSecondSignUpAvailable)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationView {
        SecondSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
