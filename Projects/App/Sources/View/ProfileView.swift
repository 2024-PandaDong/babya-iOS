//
//  ProfileView.swift
//  babya
//
//  Created by hyk on 6/2/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255)
            
            ScrollView {
                Rectangle()
                    .frame(height: 240)
                    .foregroundStyle(Color(red: 255/255, green: 203/255, blue: 41/255))
                    .overlay {
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("박규민님 반가워요!")
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.vertical, 5)
                                
                                Text("소망이 아빠 D-Day: 86일")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 12))
                                
                                HStack {
                                    Text("나이: 25살")
                                    Text("결혼: 3년차")
                                }
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                                
                                HStack {
                                    Text("산모일기: 소망이 산모일기")
                                    Image(systemName: "lock.fill")
                                }
                                .foregroundStyle(.white)
                                .font(.system(size: 12))
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Button {
                                    self.presentationMode.wrappedValue.dismiss()
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 20, weight: .light))
                                }
                                .padding(.top)
                                
                                Circle()
                                    .frame(width: 100, height: 100)
                                    .padding(.vertical, 5)
                                
                                Button {
                                    
                                } label: {
                                    Rectangle()
                                        .frame(width: 70, height: 15)
                                        .padding(.horizontal, 15)
                                        .foregroundStyle(.clear)
                                        .overlay {
                                            Rectangle().stroke(.white, lineWidth: 2)
                                            
                                            Text("프로필 수정하기")
                                                .font(.system(size: 10))
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                        }
                        .padding(.horizontal, 40)
                    }
                
                HStack {
                    Text("이동하기")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    Spacer()
                }
                
                HStack(spacing: 30) {
                    DocumentCell(image: "doc", title: "개인정보약관 상세")
                    DocumentCell(image: "person.fill.questionmark", title: "문의 하러 가기")
                    DocumentCell(image: "questionmark.folder", 
                                 title: "질문 모음")
                }
                
                HStack {
                    Text("즐겨찾기 목록")
                        .font(.system(size: 15, weight: .bold))
                    
                    Spacer()
                    
                    NavigationLink(destination: FavoritesView()) {
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 65)
                    .foregroundStyle(.white)
                    .overlay {
                        HStack(alignment: .firstTextBaseline) {
                            FavoritesPreviewCell()
                            FavoritesPreviewCell()
                            FavoritesPreviewCell()
                        }
                    }
                
                HStack {
                    Text("산모일기")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    Spacer()
                }
                
                ScrollView {
                    DiaryCell()
                    DiaryCell()
                    DiaryCell()
                    DiaryCell()
                    DiaryCell()
                    DiaryCell()
                }
                .frame(width: 350, height: 200)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    Text("산모일기")
                        .font(.system(size: 15, weight: .bold))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                    
                    Spacer()
                }
                
                ScrollView {
                    PostCell()
                    PostCell()
                    PostCell()
                    PostCell()
                    PostCell()
                    PostCell()
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
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
