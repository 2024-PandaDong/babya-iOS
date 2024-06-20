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
    
    var body: some View {
        ZStack{
            Color.gray0.ignoresSafeArea()
            circle()
                .fill(Color.yellow)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing : 5){
                        Text("애기야에 오신걸")
                            .bold()
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                        Text("환영합니다")
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 32))
                        
                        Text("로그인 방식을 선택해 주세요")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .padding(.vertical,23)
                        
                        Text("당신의 정보를 입력해주세요.")
                            .foregroundColor(Color.gray1)
                            .font(.system(size: 16))
                            .padding(.top,40)
                        
                    }
                    Spacer()
                }
                .padding([.horizontal, .top], 44)
                
                VStack(alignment: .leading) {
                    InputFieldView(text: $email, securetext: $password, showPassword: $showPassword, errorMessage: vm.is404Error ? "등록되지 않은 이메일 입니다." : nil, placeholder: "이메일", isSecure: false)
                    InputFieldView(text: $email, securetext: $password, showPassword: $showPassword, errorMessage: vm.is401Error ? "비밀번호를 잘못 입력하였습니다." : nil, placeholder: "비밀번호", isSecure: true)
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
                    ZStack{
                        Rectangle()
                            .frame(maxWidth : .infinity)
                            .frame(height: 54)
                            .foregroundColor(Color.yellow)
                            .cornerRadius(20)
                            .padding(.horizontal,40)
                            .cornerRadius(20)
                        
                        Text("로그인")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                }
                .padding(.top,45)
                
                HStack(spacing : 8){
                    Spacer()
                    Button{
                        
                    }label: {
                        Text("계정이 없으신가요?")
                            .foregroundColor(Color.gray1)
                            .font(.system(size: 12))
                    }
                    Button{
                        
                    }label: {
                        Text("회원가입")
                            .foregroundColor(Color.yellow1)
                            .font(.system(size: 12))
                    }
                }
                .padding(.top,2)
                .padding(.horizontal,40)
                
                VStack(spacing: 5) {
                    SocialLoginButton(
                        imageName: "Google",
                        title: "Google 계정으로 로그인하기",
                        backgroundColor: .white,
                        textColor: .black,
                        action: {
                            
                        }
                    )
                    
                    SocialLoginButton(
                        imageName: "Apple",
                        title: "Apple 계정으로 로그인하기",
                        backgroundColor: .black,
                        textColor: .white,
                        action: {
                            
                        }
                    )
                }
                .padding(.top, 20)
                .padding(.horizontal, 40)
                
                Spacer()
            }
            
        }
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
