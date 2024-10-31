//
//  FinalSignUpView.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct FinalSignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                Image("family")
                
                Text("애기야와 함께 따뜻한 가정을 만들어봐요!")
                    .font(.system(size: 16, weight: .semibold))
                    .padding(.vertical, 30)
                
                
                Button {
                    viewModel.signUp() {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                        .foregroundStyle(Color.PrimaryNormal)
                        .overlay {
                            Text("가입하기")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                        .padding(.horizontal, 30)
                }
                .padding(.vertical, 80)
                
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    NavigationView {
        FinalSignUpView()
            .environmentObject(SignUpViewModel())
    }
}
