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
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                
                Rectangle()
                    .frame(width: geometry.size.width / 6, height: 2)
                    .foregroundStyle(Color.PrimaryNormal)
                
                Group {
                    Text("약관에 동의해주세요")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top, 50)
                    
                    Text("약관에 동의 하시면 당신에게 더욱 좋은 서비스를\n제공해 드릴 수 있어요!")
                        .font(.system(size: 14, weight: .medium))
                        .padding(.vertical)
                    
                    HStack {
                        Button(action: {
                            viewModel.toggleTotalAccept()
                        }, label: {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 22, height: 22)
                                .foregroundStyle(!viewModel.totalAccept ? Color.PrimaryLight : .clear)
                                .overlay {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.gray, lineWidth: 1)
                                            .overlay {}
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 12).weight(.semibold))
                                            .foregroundStyle(.white)
                                    }
                                }
                        })
                        
                        Text("전체동의")
                            .font(.system(size: 15, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                    Divider()
                        .padding(.vertical)
                    
                    ForEach(viewModel.personalModel.indices, id: \.self) { index in
                        PersonalDataCell(label: viewModel.personalModel[index].personalDataLabel, index: index, isClicked: viewModel.personalModel[index].isBoxClicked) {
                            viewModel.getClickedSelection(index)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                NavigationLink(destination: SecondSignUpView().environmentObject(viewModel)) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundStyle(viewModel.isFirstSignUpAvailable ? Color.PrimaryNormal : .ComponentMaterialDimmer)
                        .overlay {
                            Text("다음으로")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                }
                .disabled(!viewModel.isFirstSignUpAvailable)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.toggleTotalAccept()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Text("16%")
                        .font(.system(size: 12))
                }
            }
            .navigationBarBackButtonHidden()
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationView {
        FirstSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
