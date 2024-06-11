//
//  DiaryView.swift
//  babya
//
//  Created by dgsw8th61 on 5/23/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import SwiftUI

struct DiaryView : View {
    let columns = [GridItem(.fixed(180)),
                   GridItem(.fixed(180))]
    @State var All : Bool = true
    @State var myDiary : Bool = false
    @State var Diary : Bool = true
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Rectangle()
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity)
                        .frame(height: 130)
                        .overlay {
                            ZStack{
                                Text("이번주 건강상태는 좋음입니다.\n오늘도 좋은하루 보내세요!")
                                    .bold()
                                    .font(.system(size: 20))
                                    .padding(.horizontal)
                                    .padding(.trailing,65)
                                
                                HStack(spacing: 10){
                                    Spacer()
                                    Image("character")
                                        .padding(.top,50)
                                        .padding(.horizontal,15)
                                }
                            }
                        }
                    HStack(spacing: 20){
                        Button(action: {
                            All = true
                            myDiary = false
                        }, label: {
                            Text("전체")
                                .foregroundColor(All ? Color.yellow : Color.black)
                                .underline(All)
                            
                        })
                        Button(action: {
                            myDiary = true
                            All = false
                        }, label: {
                            Text("나의 일기")
                                .foregroundColor(myDiary ? Color.yellow : Color.black)
                                .underline(myDiary)
                        })
                        Spacer()
                        
                        if myDiary{
                            HStack(spacing: 2){
                                Button(action: {
                                    Diary.toggle()
                                }, label: {
                                    Text(Diary ? "공개" : "비공개")
                                        .foregroundStyle(.black)
                                })
                                Image(systemName: Diary ? "lock.open" : "lock" )
                            }
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,20)
                    Divider()
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach((0...2), id: \.self) { _ in
                                NavigationLink(destination: UserDetailDiaryView(PostName: "포스트이름", DiaryImage: "Image"))
                                {
//                                                         DetailDiaryView(inputText: "", DiaryImage: "Image",  Content: "내용", PostName: "포스트이름")) {
                                    DiaryCeil(ProfileImage: "Image", Title: "타이틀", UserName: "유저이름")
                                        .padding(.vertical,5)
                                }
                            }
                        }
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationTitle("산모일기")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {
                            //
                        } label: {
                            Image("reset")
                                .resizable()
                                .frame(width: 18,height: 18)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            //
                        } label: {
                            Image("arrow")
                                .resizable()
                                .frame(width: 18,height: 18)
                        }
                        
                        
                    }
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        PencilButton()
                            .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    DiaryView()
}
