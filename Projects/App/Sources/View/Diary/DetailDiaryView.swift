//
//  DetailDiaryView.swift
//  babya
//
//  Created by dgsw8th61 on 6/4/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct DetailDiaryView : View {
    @State var inputText : String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm : DiaryViewModel
    var Diary: DiaryResponse
    @State var nowPage : Int = 1
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading){
                        Image(Diary.files.first??.url ?? "Image")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding(.horizontal,15)
                        
                        
                        TextTitleStyle(Title: Text("본문"))
                            .padding(.vertical,7)
                        
                        TextContentStyle(content: Text(Diary.content))
                        HStack{
                            Spacer()
                            Text(Diary.writtenDt)
                                .font(.system(size: 11))
                                .foregroundStyle(.gray)
                                .padding(15)
                        }
                        Divider()
                        
                        ScrollView(showsIndicators: false) {
                            ForEach((0..<vm.commentcount  ), id: \.self) { count in
                                CommentCeil(ProfileImage:vm.comment[count].profileImg ?? "Image",
                                            UserName: vm.comment[count].nickname,
                                            Days: vm.comment[count].createdAt,
                                            Content: vm.comment[count].content)
                                    .padding(.vertical,5)
                                    .onAppear{
                                        if count == 9 {
                                            nowPage += 1
                                            print("page :: \(nowPage)")
                                        }
                                    }
                            }
                        }
                        
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
        .task{
            nowPage = 1
            await vm.getCommentDiary(pageRequest: PageRequest(page: 1, size: 10), id: Diary.diaryId)
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(Diary.title)
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                }, label: {
                    Image("dots")
                        .resizable()
                        .frame(width: 18)
                })
            }
        }
    }
}

extension View{
    func TextContentStyle(content : Text) -> some View{
        content
            .font(.system(size: 12))
            .padding(.horizontal,15)
            .multilineTextAlignment(.leading)
        
    }
    
    func TextTitleStyle(Title : Text) -> some View{
        Title
            .font(.system(size: 16))
            .bold()
            .padding(.horizontal,15)
    }
}
