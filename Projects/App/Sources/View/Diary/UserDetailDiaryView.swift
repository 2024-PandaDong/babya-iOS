//
//  UserDetailDiaryView.swift
//  babya
//
//  Created by dgsw8th61 on 6/6/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct UserDetailDiaryView : View {
    var PostName : String
    var DiaryImage : String
    @State var weight: String = ""
    @State var weeks : String = ""
    @State var Opinion : String = ""
    @State var BloodPressure1 : String = ""
    @State var BloodPressure2 : String = ""
    @State var Content : String = ""
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Image(DiaryImage)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.horizontal,15)
                        .padding(.vertical,20)
                    
                    VStack(alignment: .leading ,spacing: 15){
                        HStack{
                            VStack(alignment: .leading ,spacing: 10){
                                HStack(spacing:7){
                                    Text("체중:")
                                        .font(.system(size: 13))
                                    LineTextField(text: $weight, TextFieldWidth: 30)
                                    Text("kg")
                                        .font(.system(size: 13))
                                        .padding(.trailing,30)
                                    
                                    Text("임신주수:")
                                        .font(.system(size: 13))
                                    LineTextField(text: $weight, TextFieldWidth: 30)
                                    Text("주")
                                        .font(.system(size: 13))
                                }
                                HStack(spacing:7){
                                    Text("혈압:")
                                        .font(.system(size: 13))
                                    LineTextField(text: $BloodPressure1, TextFieldWidth: 30)
                                    Text("/")
                                        .font(.system(size: 13))
                                    LineTextField(text: $BloodPressure2, TextFieldWidth: 30)
                                        .padding(.trailing,30)
                                    
                                    Text("다음 진찰일:")
                                        .font(.system(size: 13))
                                    Text("12/16")
                                        .font(.system(size: 13))
                                }
                            }
                            Spacer()
                            VStack(spacing:5){
                                Image("좋음 이모티콘")
                                    .resizable()
                                    .frame(width: 45,height: 45)
                                Text("좋음")
                                    .font(.system(size: 12))
                            }
                        }
                        
                        Text("태아소견")
                            .font(.system(size: 16))
                            .bold()
                        
                        LineTextField(text: $Opinion, TextFieldWidth: .infinity)
                        
                        Text("내용")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.top,5)
                        
                        ScrollView {
                            TextEditor(text: $Content)
                                .frame(maxWidth:.infinity,minHeight: 200, maxHeight: .infinity)
                                .padding(.horizontal, -8)
                                .padding(.vertical, -10)
                                .font(.system(size: 14))
                                .focused($isTextFieldFocused)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.isTextFieldFocused = true
                                    }
                                }
                                .overlay(alignment: .topLeading) {
                                    Text("내용을 입력하세요")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Content.isEmpty ? .gray : .clear)
                                }
                        }
                        Divider()
                        UserProfile(ProfileImage: "Image", UserName: "dbwj")
                        HStack(spacing: 7){
                            LineTextField(text: $Opinion, TextFieldWidth: .infinity)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.isTextFieldFocused = true
                                    }
                                }
                                .overlay(alignment: .topLeading) {
                                    Text("댓글 쓰기")
                                        .font(.system(size: 14))
                                        .foregroundStyle(Content.isEmpty ? .gray : .clear)
                                }
                            Image("pencil")
                                .resizable()
                                .frame(width: 15,height: 15)
                        }
                        .padding(.horizontal,30)
                        .padding(.bottom,10)
                        
                        CommentCeil(ProfileImage: "Image", UserName: "유저", Days: "11일", Content: "안녕핫에요")
                    }
                    .padding(.horizontal,20)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(PostName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("arrow")
                        .resizable()
                        .frame(width: 18,height: 18)
                }
            }
            
            ToolbarItem(placement:.navigationBarTrailing) {
                Button(action: {
                    //
                }, label: {
                    Text("수정")
                        .foregroundColor(.white)
                        .padding(.horizontal,16)
                        .padding(.vertical,10)
                        .background(Color.yellow)
                        .cornerRadius(10)
                })
            }
        }
    }
}

#Preview {
    UserDetailDiaryView(PostName: "포스트이름", DiaryImage: "Image")
}
