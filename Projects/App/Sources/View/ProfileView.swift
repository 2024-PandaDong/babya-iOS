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
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255)
            
            ScrollView {
                Rectangle()
                    .frame(height: 240)
                    .foregroundStyle(Color(red: 255/255, green: 203/255, blue: 41/255))
                    .overlay {
                        VStack {
                            Spacer()
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(viewModel.model.data.nickname)님 반가워요!")
                                        .font(.system(size: 20, weight: .bold))
                                        .padding(.vertical, 5)
                                    
                                    Text(viewModel.model.data.dDay == nil ? "D-Day: X" : "D-Day: \(viewModel.model.data.dDay)일")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 12))
                                    
                                    HStack {
                                        Text("나이: \(viewModel.model.data.age)살")
                                        Text(viewModel.model.data.marriedYears == nil ? "결혼: X" : "결혼: \(viewModel.model.data.marriedYears)년차")
                                    }
                                    .foregroundStyle(.white)
                                    .font(.system(size: 12))
                                    
//                                    HStack {
//                                        Text(viewModel.model.data.children?[0]?.birthName == nil ? "산모일기: X" : "\(viewModel.model.data.children?[0]?.birthName) 산모일기")
//                                        Image(systemName: "lock.fill")
//                                    }
//                                    .foregroundStyle(.white)
//                                    .font(.system(size: 12))
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Circle()
                                        .frame(width: 100, height: 100)
                                }
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 25)
                        }
                    }
                
//                HStack {
//                    Text("즐겨찾기 목록")
//                        .font(.system(size: 15, weight: .bold))
//                    
//                    Spacer()
//                    
//                    NavigationLink(destination: FavoritesView()) {
//                        Image(systemName: "arrow.right")
//                            .foregroundStyle(.black)
//                    }
//                }
//                .padding(.horizontal, 30)
//                .padding(.vertical, 10)
//                
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: 350, height: 65)
//                    .foregroundStyle(.white)
//                    .overlay {
//                        HStack(alignment: .firstTextBaseline) {
//                            FavoritesPreviewCell()
//                            FavoritesPreviewCell()
//                            FavoritesPreviewCell()
//                        }
//                    }
                
                HStack {
                    Text("산모일기")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    Spacer()
                }
                
                ScrollView {
                    if viewModel.myDiary.data.isEmpty {
                        Text("아직 산모일기를 작성하지 않았어요")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.vertical)
                    } else {
                        ForEach(0..<viewModel.myDiary.data.count, id: \.self) { index in
                            DiaryCell(writtenDt: viewModel.myDiary.data[index].writtenDt, title: viewModel.myDiary.data[index].title)
                        }
                    }
                }
                .frame(width: 350, height: 200)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    Text("게시물")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    Spacer()
                }
                
                ScrollView {
                    if viewModel.myPost.data.isEmpty {
                        Text("아직 게시물을 작성하지 않았어요")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.vertical)
                    } else {
                        ForEach(0..<viewModel.myPost.data.count, id: \.self) { index in
                            PostCell(createdAt: viewModel.myPost.data[index].createdAt, title: viewModel.myPost.data[index].title)
                        }
                    }
                }
                .frame(width: 350, height: 200)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                    .frame(height: 120)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                        .font(.system(size: 20, weight: .light))
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Toggle(isOn: $showDiary) {
                        Text("일일퀴즈")
                    }
                    NavigationLink(destination: Text("프로필 수정")) {
                        Text("프로필 수정하기")
                    }
                    NavigationLink(destination: Text("프로필 수정")) {
                        Text("개인정보 약관 상세")
                    }
                    NavigationLink(destination: Text("프로필 수정")) {
                        Text("문의하기")
                    }
                    NavigationLink(destination: Text("프로필 수정")) {
                        Text("FAQ")
                    }
                    Button(role: .destructive) {
                        print("로그아웃")
                        LoginUserHashCache.shared.logout()
                    } label: {
                        Text("로그아웃")
                            .tint(.red)
                    }
                    Button(role: .destructive) {
                        
                    } label: {
                        Text("탈퇴하기")
                            .tint(.red)
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.black)
                }
            }
        }
        .onAppear {
            viewModel.getMyProfile()
            viewModel.getMyPosts(page: 1, size: 10)
            viewModel.getMyDiary(page: 1, size: 10)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
