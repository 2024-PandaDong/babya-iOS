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
                    CustomDatePicker("결혼일(선택)", target: $viewModel.model.marriedDt)
                        .padding(.top, 40)
                    
                    RadioCell(title: "임신여부", isCheck: $viewModel.model.isPregnant)
                    
                    if viewModel.model.isPregnant {
                        CustomDatePicker("임신일", target: $viewModel.model.pregnancyDt)
                        
                        NameList(title: "태명", placeholder: "태명을 입력 해주세요.", target: $viewModel.model.childList, isBirth: false)
                    }
                    
                    RadioCell(title: "자녀여부", isCheck: $viewModel.model.hasChild)
                        .padding(.vertical)
                    
                    if viewModel.model.hasChild {
                        NameList(title: "자녀이름", placeholder: "자녀의 이름을 입력 해주세요.", target: $viewModel.model.birthList, isBirth: true)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("약관동의")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 30)
                        
                        HStack {
                            Button(action: {
                                viewModel.toggleTotalAccept()
                            }, label: {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 22, height: 22)
                                    .foregroundStyle(.clear)
                                    .overlay {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.gray, lineWidth: 1)
                                                .overlay {}
                                            Image(systemName: "checkmark")
                                                .font(.system(size: 12).weight(.semibold))
                                                .foregroundStyle(viewModel.totalAccept ? .clear : .black)
                                        }
                                    }
                            })
                            Text("전체동의")
                                .font(.system(size: 15, weight: .bold))
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                        .padding(.top)
                    }
                    .padding(.top)
                    
                    Divider()
                        .padding(.horizontal, 30)
                    
                    VStack {
                        ForEach(viewModel.personalModel.indices, id: \.self) { index in
                            PersonalDataCell(label: viewModel.personalModel[index].personalDataLabel, isClicked: viewModel.personalModel[index].isBoxClicked) {
                                viewModel.getClickedSelection(index)
                            }
                        }
                    }
                }
                
                SignUpButton(isAvailable: viewModel.isSecondSignUpAvailable, action: {
                    print(viewModel.model.params)
                    viewModel.signUp()
                })
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        SecondSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
