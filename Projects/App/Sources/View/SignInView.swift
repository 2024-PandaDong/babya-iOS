//
//  ContentView.swift
//  babeyaview
//
//  Created by dgsw8th61 on 4/17/24.
//

import SwiftUI

struct SignInView : View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false

    @StateObject var vm : SignInViewModel
    @StateObject var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing : 5){
                        Text("\(Text("애기야").foregroundColor(Color.PrimaryLight).font(.system(size: 26)))에 오신걸 \n환영합니다")
                            .bold()
                            .font(.system(size: 23))
                            .foregroundColor(.black)
    
                    }
                    Spacer()
                }
                .padding([.horizontal, .top], 44)
                
                VStack(alignment: .leading,spacing: 15) {
                    InputFieldView(text: $email, securetext: $password, showPassword: $showPassword, errorMessage: vm.is404Error ? "등록되지 않은 이메일 입니다." : nil, placeholder: "E-mail", isSecure: false)
                    InputFieldView(text: $email, securetext: $password, showPassword: $showPassword, errorMessage: vm.is401Error ? "비밀번호를 잘못 입력하였습니다." : nil, placeholder: "Password", isSecure: true)
                }
                .padding(.top, 25)
                .padding(.horizontal, 40)
                
                Button{
                    self.hideKeyboard()
                    vm.is401Error = false
                    vm.is404Error = false
                    Task{
                         await vm.login(email: email,password:password)
                    }
                }label: {
                    var loginBool = email != "" && password != ""
                    ZStack{
                        Rectangle()
                            .frame(maxWidth : .infinity)
                            .frame(height: 43)
                            .foregroundColor(loginBool ? Color.PrimaryLight : Color.LabelDisable)
                            .cornerRadius(10)
                            .padding(.horizontal,40)
                        
                        Text("로그인하기")
                            .foregroundColor(.white)
                            .font(.system(size: 16,weight: .bold))
                            .disabled(email == "" && password == "")
                    }
                }
                .padding(.top,15)
                
                HStack(spacing : 8){
                    Spacer()
                    NavigationLink(isActive: $signUpViewModel.rootActive) {
                        FirstSignUpView()
                            .environmentObject(signUpViewModel)
                        
                    } label: {
                        Text("회원가입하기")
                            .foregroundColor(Color.LabelDisable)
                            .font(.system(size: 12,weight: .semibold))
                    }
                    
                }
                .padding(.top,2)
                .padding(.horizontal,40)
                
                Spacer()

                HStack{
                    VStack {
                        Divider()
                            .foregroundColor(Color.LineAlternative)
                            .frame(height: 2)
                            
                    }
                    Text("or")
                        .foregroundColor(Color.LineAlternative)
                        .font(.system(size: 14,weight: .semibold))
                    VStack {
                        Divider()
                            .foregroundColor(Color.LineAlternative)
                            .frame(height: 2)
                    }
                }
                .padding(.horizontal,10)
                
                VStack(spacing: 5) {
                    SocialLoginButton(
                        imageName: "Google",
                        title: "Google 계정으로 로그인하기",
                        backgroundColor: .white,
                        textColor: Color.LineAlternative,
                        action: {
                            
                        }
                    )
                }
                .padding(.horizontal, 40)
            }
        }
    }
}
