//
//  ProfileView.swift
//  babya
//
//  Created by hyk on 6/2/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showDiary: Bool = true
    
    @StateObject var viewModel = ProfileViewModel()
    @StateObject var signInViewModel = SignInViewModel(authService: RemoteAuthService())
    
    @State var isQuiz: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.top, -50)
            
            AsyncImage(url: URL(string: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg")) { image in
                image
                    .image?
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(Circle())
            }
            
            Text("ㅇㅇㅇ 아빠님 반가워요!")
                .font(.system(size: 20, weight: .medium))
                .padding(.vertical)
            
            Divider()
            
            NavigationLink(destination: Text("프로필 수정")) {
                Rectangle()
                    .frame(height: 60)
                    .foregroundStyle(.clear)
                    .overlay {
                        HStack {
                            Text("프로필 수정")
                                .foregroundStyle(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.LineNormal)
                        }
                        .padding(.horizontal, 25)
                    }
            }
            
            Divider()
            
            Rectangle()
                .frame(height: 60)
                .foregroundStyle(.clear)
                .overlay {
                    HStack {
                        Text("일일퀴즈 설정")
                        
                        Spacer()
                        
                        Toggle(isOn: $isQuiz) {
                            
                        }
                        .tint(Color.PrimaryLight)
                    }
                    .padding(.horizontal, 25)
                }
            
            Rectangle()
                .frame(height: 10)
                .foregroundStyle(Color(red: 247/255, green: 247/255, blue: 247/255))
            
            LinkCell(title: "약관 및 개인정보 처리 동의", link: "www.youtube.com", isLast: false)
            LinkCell(title: "개인정보 처리 방침", link: "www.google.com", isLast: true)
            
            Rectangle()
                .frame(height: 10)
                .foregroundStyle(Color(red: 247/255, green: 247/255, blue: 247/255))
            
            Rectangle()
                .frame(height: 60)
                .foregroundStyle(.clear)
                .overlay {
                    HStack {
                        Text("앱 버전")
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Text("최신 버전")
                            .foregroundStyle(Color.LineNormal)
                    }
                    .padding(.horizontal, 25)
                }
            
            
            Rectangle()
                .frame(height: 10)
                .foregroundStyle(Color(red: 247/255, green: 247/255, blue: 247/255))
            
            OutingCell(title: "로그아웃") {
                
            }
            
            OutingCell(title: "회원탈퇴") {
                
            }
            
            
            
            Spacer()
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
            
            ToolbarItem(placement: .principal) {
                Text("프로필")
                    .font(.system(size: 16, weight: .medium))
            }
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
