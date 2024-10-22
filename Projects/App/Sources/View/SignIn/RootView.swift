//
//  RootView.swift
//  babya
//
//  Created by hyk on 9/12/24.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = SignUpViewModel()
    @State var showLogin: Bool = false
    
    var body: some View {
        VStack(spacing: 25) {
            Image("logo")
            
            Text("애기야에 오신 것을 환영합니다.")
                .font(.system(size: 20, weight: .semibold))
            
            Text("저희는 임산부 여러분이 정책을 쉽게\n이해하고, 필요한 지원을 받으실 수\n있도록 도와드리는 도우미입니다.")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color.LabelAlternative)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            Image("mockup")
            
            Spacer()
                .frame(height: 10)
            
            NavigationLink(destination: FirstSignUpView().environmentObject(viewModel), isActive: $viewModel.rootActive) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 340, height: 50)
                    .foregroundStyle(Color.PrimaryNormal)
                    .overlay {
                        Text("회원가입")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
            }
            .padding(.top, 30)
            
            HStack {
                Text("이미 회원이십니까?")
                
                Button {
                    showLogin = true
                } label: {
                    Text("로그인하세요")
                        .fontWeight(.medium)
                        .foregroundStyle(Color.PrimaryNormal)
                }
            }
            .font(.system(size: 13))
        }
        .sheet(isPresented: $showLogin) {
            SignInView(vm: SignInViewModel(authService: RemoteAuthService()))
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationView {
        RootView()
    }
}
