//
//  ContentView.swift
//  babeyaview
//
//  Created by dgsw8th61 on 4/17/24.
//

import SwiftUI

struct SignInView : View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false

    @StateObject var vm : SignInViewModel
    @EnvironmentObject var signUpViewModel : SignUpViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("애기야에 로그인하세요")
                    .font(.system(size: 23, weight: .medium))
                
                HStack {
                    Text("회원이 아니신가요?")
                        .font(.system(size: 13, weight: .regular))
                    
                    NavigationLink(destination: FirstSignUpView()
                        .environmentObject(signUpViewModel)) {
                            Text("회원가입하기")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundStyle(Color.PrimaryNormal)
                    }
                }
        
                InputFieldView(text: $email, securetext: $password, showPassword: $showPassword, errorMessage: vm.is404Error ? "등록되지 않은 이메일 입니다." : nil, placeholder: "이메일", isSecure: false)
                    .padding(.vertical, 20)
                
                InputFieldView(text: $email, securetext: $password, showPassword: $showPassword, errorMessage: vm.is401Error ? "비밀번호를 잘못 입력하였습니다." : nil, placeholder: "비밀번호", isSecure: true)
                
                Button{
                    self.hideKeyboard()
                    vm.is401Error = false
                    vm.is404Error = false
                    Task{
                        await vm.login(email: email,password:password) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .foregroundStyle(email.isEmpty && password.isEmpty ? Color.ComponentMaterialDimmer : .PrimaryNormal)
                        .overlay {
                            Text("로그인")
                                .foregroundStyle(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                }
                .padding(.top, 50)
                .disabled(email.isEmpty && password.isEmpty)
                
                Spacer()
            }
            .padding(.horizontal, 30)
        .padding(.vertical, 50)
        }
    }
}

#Preview {
    NavigationView {
        SignInView( vm: SignInViewModel(authService: RemoteAuthService()))
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.gray)
    }
}

struct circle : Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.size.width, y: 0))
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height/4.9))
            path.addLine(to: CGPoint(x: 0, y: rect.size.height/3.3))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.closeSubpath()
            
            path.move(to: CGPoint(x: rect.size.width, y: rect.size.height/4.9))
            path.addQuadCurve(to: CGPoint(x: 0,y: rect.size.height/3.3), control: CGPoint(x: rect.size.width/1.3, y: rect.size.height/2.7))
            path.closeSubpath()
            
        }
    }
}
