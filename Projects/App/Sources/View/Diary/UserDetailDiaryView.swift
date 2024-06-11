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
    @State var inputText : String = ""
    @State var weight: String = "20"
    @State var weeks : String = "2주"
    @State var Opinion : String = "좋습니다"
    @State var BloodPressure1 : String = "130"
    @State var BloodPressure2 : String = "60"
    @State var Content : String = "일기 내용"
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
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
                                        TextLineStyle(text: weight)
                                        
                                        Text("kg")
                                            .font(.system(size: 13))
                                            .padding(.trailing,30)
                                        
                                        Text("임신주수:")
                                            .font(.system(size: 13))
                                        TextLineStyle(text: weeks)
                                        Text("주")
                                            .font(.system(size: 13))
                                    }
                                    HStack(spacing:7){
                                        Text("혈압:")
                                            .font(.system(size: 13))
                                        TextLineStyle(text: BloodPressure1)
                                        Text("/")
                                            .font(.system(size: 13))
                                        TextLineStyle(text: BloodPressure2)
                                            .padding(.trailing,14)
                                        
                                        Text("다음 진찰일:")
                                            .font(.system(size: 13))
                                        Text("12/16")
                                            .font(.system(size: 13))
                                    }
                                }
                                Spacer()
                                VStack(spacing:5){
                                    Image("happy")
                                        .resizable()
                                        .frame(width: 45,height: 45)
                                    Text("좋음")
                                        .font(.system(size: 12))
                                }
                            }
                            
                            Text("태아소견")
                                .font(.system(size: 16))
                                .bold()
                            
                            Text(Opinion)
                                .font(.system(size: 12))
                                .multilineTextAlignment(.leading)
                            
                            Text("내용")
                                .font(.system(size: 16))
                                .bold()
                                .padding(.top,5)
                            
                            
                            Text(Content)
                                .font(.system(size: 12))
                                .multilineTextAlignment(.leading)
                        }
                        .padding(.horizontal,20)
                        HStack{
                            Spacer()
                            Text("2024/01/23")
                                .font(.system(size: 11))
                                .foregroundStyle(.gray)
                                .padding(15)
                        }
                        Divider()
                        CommentCeil(ProfileImage: "Image", UserName: "유저", Days: "11일", Content: "안녕핫에요")
                    }
                    
                }
                ZStack{
                    HStack(spacing: 1){
                        Image("Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(minWidth: 25,maxHeight: 25)
                        
                        TextField("댓글달기", text: $inputText)
                            .textFieldStyle(TextfieldStyle())
                    }
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
                NavigationLink {
                    DiaryWritingView(title: "",PostName: "dsa",DiaryImage: "Image")
                } label: {
                    Image("dots")
                        .resizable()
                        .frame(width: 18)
                }
            }
        }
    }
}

#Preview {
    UserDetailDiaryView(PostName: "포스트이름", DiaryImage: "Image")
}
