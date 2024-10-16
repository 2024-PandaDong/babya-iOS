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
                Divider()
                
                Rectangle()
                    .frame(width: geometry.size.width / 2, height: 2)
                    .foregroundStyle(Color.PrimaryNormal)
                
                Group {
                    Text("당신의 이름은?")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 50)
                    
                    SignUpTextField(content: $viewModel.model.nickName, placeholder: "ex) 박규민")
                    
                    Text("당신의 생일은?")
                        .font(.system(size: 20, weight: .bold))
                    
                    CustomDatePicker(target: $viewModel.model.birthDt, prompt: "당신의 생일은?")
                    
                    Text("당신의 결혼기념일은?")
                        .font(.system(size: 20, weight: .bold))
                    
                    CustomDatePicker(target: $viewModel.model.marriedDt, prompt: "당신의 결혼기념일은?")
                    
                    Text("당신이 사는 지역은??")
                        .font(.system(size: 20, weight: .bold))
                    
                    LocationPicker()
                        .environmentObject(viewModel)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Spacer()
                
                NavigationLink(destination: FourthSignUpView().environmentObject(viewModel)) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
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
        ThirdSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
