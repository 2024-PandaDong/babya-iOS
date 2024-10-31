//
//  ThirdSignUpView.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct ThirdSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("당신의 이름은?")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 50)
                        .padding(.vertical, 10)
                    
                    SignUpTextField(content: $viewModel.model.nickName, placeholder: "ex) 박규민")
                        .padding(.vertical, 10)
                    
                    Text("당신의 생일은? (선택)")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 10)
                    
                    CustomDatePicker(target: $viewModel.model.birthDt, prompt: "당신의 생일은?")
                        .padding(.vertical, 10)
                    
                    Text("당신의 결혼기념일은? (선택)")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 10)
                    
                    CustomDatePicker(target: $viewModel.model.marriedDt, prompt: "당신의 결혼기념일은?")
                        .padding(.vertical, 10)
                    
                    Text("당신이 사는 지역은??")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 10)
                    
                    Text("지역 정보를 통해 사용자에게 맞춤형 서비스를 제공합니다.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.LabelAssistive)
                        
                    
                    LocationPicker()
                        .environmentObject(viewModel)
                        .padding(.vertical, 10)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    withAnimation {
                        viewModel.pageNum += 1
                        viewModel.percentage += 17
                        viewModel.width += 66
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(viewModel.isThirdSignUpAvailable ? Color.PrimaryNormal : .ComponentMaterialDimmer)
                        .overlay {
                            Text("다음으로")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                }
                .disabled(!viewModel.isThirdSignUpAvailable)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationView {
        ThirdSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
