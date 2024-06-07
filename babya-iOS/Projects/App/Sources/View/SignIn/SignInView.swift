//
//  ContentView.swift
//  babeyaview
//
//  Created by dgsw8th61 on 4/17/24.
//

import SwiftUI

struct SignInView : View {
    @State var text = ""
    @State var securetext = ""
    @State private var showPassword = false
    
    var body: some View {
        ZStack{
            Color(UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)).ignoresSafeArea()
            circle()
                .fill(.gray)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    VStack(alignment: .leading, spacing : 5){
                        Text("애기야에 오신걸")
                            .bold()
                            .font(.system(size: 32))
                        Text("환영합니다")
                            .bold()
                            .font(.system(size: 32))
                        
                        Text("로그인 방식을 선택해 주세요")
                            .bold()
                            .font(.system(size: 16))
                            .padding(.vertical,23)
                        
                        Text("당신의 정보를 입력해주세요.")
                            .font(.system(size: 16))
                            .padding(.top,40)
                        
                    }
                    Spacer()
                }
                .padding([.horizontal, .top], 44)
                
                VStack(alignment : .leading){
                    Text("이메일")
                        .font(.system(size: 13))
                        .padding(.top,10)
                    
                    HStack {
                        TextField("", text: $text)
                    }.underlineTextField()
                    
                    Text("비밀번호")
                        .font(.system(size: 13))
                        .padding(.top,10)
                    HStack {
                        if showPassword {
                            TextField("",text: $securetext)
                        } else {
                            SecureField("", text: $securetext)
                        }
                        Button{
                            self.showPassword.toggle()
                            
                        }label: {
                            Image(systemName: "eye")
                                .resizable()
                                .frame(width: 15,height: 10)
                                .foregroundColor(.secondary)
                        }
                    }.underlineTextField()
                }
                .padding(.top,25)
                .padding(.horizontal,40)
                
                Button{
                    
                }label: {
                    ZStack{
                        Rectangle()
                            .frame(maxWidth : .infinity,maxHeight: 54)
                            .foregroundColor(.gray)
                            .cornerRadius(20)
                            .padding(.horizontal,40)
                            .cornerRadius(20)
                        
                        Text("로그인")
                            .font(.system(size: 20))
                    }
                }
                .padding(.top,45)
                
                HStack(spacing : 8){
                    Spacer()
                    Button{
                        
                    }label: {
                        Text("계정이 없으신가요?")
                            .font(.system(size: 12))
                    }
                    Button{
                        
                    }label: {
                        Text("회원가입")
                            .font(.system(size: 12))
                    }
                }
                .padding(.top,2)
                .padding(.horizontal,40)
                
                VStack(spacing : 5){
                    Button{
                        
                    }label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity,maxHeight: 45)
                                .cornerRadius(30)
                            HStack(spacing : 40){
                                Image("Google")
                                    .resizable()
                                    .frame(width: 27,height: 23)
                                Text("Google 계정으로 로그인하기")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.vertical,6)
                    Button{
                        
                    }label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity,maxHeight: 45)
                                .cornerRadius(30)
                            HStack(spacing : 50){
                                Image("Apple")
                                    .resizable()
                                    .frame(width: 28,height: 28)
                                Text("Apple 계정으로 로그인하기")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.vertical,6)
                    
                }
                .padding(.top,20)
                .padding(.horizontal,40)
                
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


#Preview {
    SignInView()
}
