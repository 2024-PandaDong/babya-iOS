//
//  FifthSignUpView.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct FifthSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView {
                        Group {
                            if viewModel.familyType == 2 || viewModel.familyType == 4 {
                                HStack {
                                    Text("당신의 태아는...")
                                        .font(.system(size: 20, weight: .semibold))
                                    .padding(.top, 40)
                                    
                                    Spacer()
                                }
                                
                                CustomDatePicker(target: $viewModel.model.pregnancyDt, prompt: "태아를 가지게 된 날을 선택해주세요!")
                                
                                NameList(placeholder: "태아 이름을 입력해주세요.", target: $viewModel.model.birthList, isBirth: false)
                                    .padding(.top, 10)
                            }
                            
                            if viewModel.familyType == 3 || viewModel.familyType == 4 {
                                HStack {
                                    Text("당신의 아이는...")
                                        .font(.system(size: 20, weight: .semibold))
                                    .padding(.top, 40)
                                    
                                    Spacer()
                                }
                                
                                NameList(placeholder: "아이 이름을 입력해주세요.", target: $viewModel.model.childList, isBirth: true)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    }
                }
            }
            
            VStack {
                Spacer()
                
                Button {
                    withAnimation {
                        viewModel.pageNum += 1
                        viewModel.percentage += 15
                        viewModel.width = 395
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(viewModel.isFifthSignUpAvailable ? Color.PrimaryNormal : .ComponentMaterialDimmer)
                        .overlay {
                            Text("다음으로")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                }
                .disabled(!viewModel.isFifthSignUpAvailable)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        FifthSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
