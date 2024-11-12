//
//  ProfileView.swift
//  babya
//
//  Created by hyk on 6/2/24.
//

import SwiftUI
import FlowKit

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showDiary: Bool = true
    
    @StateObject var viewModel = ProfileViewModel.shared
    
    @State var isQuiz: Bool = false
    @Flow var flow
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.top, -50)
            
            if let img = viewModel.model.data.profileImg {
                AsyncImage(url: URL(string: img)) { image in
                    image
                        .image?
                        .resizable()
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                        .clipShape(Circle())
                }
            } else {
                Image("baseProfile")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipShape(Circle())
            }
            
            Text("\(viewModel.model.data.nickname)님 반가워요!")
                .font(.system(size: 20, weight: .medium))
                .padding(.vertical)
            
            Divider()
        
            Button{
                flow.push(ProfileCheckView(),animated: false)
            }label: {
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
            
            TermsCell(title: "약관 및 개인정보 처리 동의", link: "https://www.notion.so/1169bbf0448c80e1accdc3511654fe06", isLast: false)
            TermsCell(title: "서비스 이용 약관", link: "https://www.notion.so/1279bbf0448c80eeba5fe9cfbca9b6d8", isLast: true)
            
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
                        
                        Text("1.0.1")
                            .foregroundStyle(Color.LineNormal)
                    }
                    .padding(.horizontal, 25)
                }
            
            
            Rectangle()
                .frame(height: 10)
                .foregroundStyle(Color(red: 247/255, green: 247/255, blue: 247/255))
            
            Button{
                flow.popToRoot()
            }label: {
                OutingCell(title: "로그아웃") {
                    LoginUserHashCache.shared.logout()
                }
            }
            Button{
                flow.popToRoot()
            }label: {
                OutingCell(title: "회원탈퇴") {
                    viewModel.withdraw()
                }
            }
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    flow.pop()
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
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.getMyProfile()
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
