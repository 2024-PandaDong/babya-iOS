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
    @State var parentIds : Int = 0
    @State var subCommentBool : Bool = false
    var Diary: DiaryResponse
    @State var nowPage : Int = 1
    @State var cumulative : Int = 0
    @State var nowcommentPage : Int = 1
    @State var subresponse = [SubCommentResponse]()
    @State var isClick : Bool = false
    var body: some View {
        if #available(iOS 17.0, *) {
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
                                ForEach((0..<vm.commentcount), id: \.self) { count in
                                    CommentCeil(Comment: vm.comment[count]/*, subcomment: subresponse, isSub: subCommentBool*/)
                                    .padding(.vertical,5)
                                    .onAppear{
                                        if count == 9 {
                                            nowPage += 1
                                            print("page :: \(nowPage)")
                                        }
                                        if vm.comment[count].subCommentCnt != 0 {
                                            subCommentBool = true
                                            Task{
                                                nowcommentPage = 1
                                                let response: () = await vm.getSubCommentDiary(pageRequest: PageRequest(page: nowcommentPage, size: 10),   parentId: vm.comment[count].commentId)
                                                subresponse = vm.subcomment
                                                
                                            }
                                        }else{
                                            subCommentBool = false
                                        }
                                        print("count : \(count)")
                                    }
//                                    if vm.comment[count].subCommentCnt != 0 {
//                                        ForEach((0..<vm.subcommentcount), id: \.self) { index in
//                                            SubCommentCeil(ProfileImage: vm.subcomment[index].profileImg ?? "Image",
//                                                           UserName: vm.subcomment[index].nickname,
//                                                           Days: vm.subcomment[index].createdAt,
//                                                           Content: vm.subcomment[index].content)
//                                            .padding(.leading, 10)
//                                            .onAppear {
//                                                if index == 9 {
//                                                    nowcommentPage += 1
//                                                    print("page :: \(nowcommentPage)")
//                                                }
////                                                if index == vm.subcommentcount {
////                                                    subCommentBool = false
////                                                    cumulative += vm.subcommentcount - 1
////                                                    print("컬티베이티브 : \(cumulative)")
////                                                }
//                                                
//                                                print("index : \(index)")
//                                                print("답글 수 : \(vm.subcommentcount)")
//                                            }
//                                        }
//                                    }
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
                                .textFieldStyle(TextfieldStyle(isClick: $isClick))
                            
                        }
                    }
                }
            }
            .task{
                nowPage = 1
                await vm.getCommentDiary(pageRequest: PageRequest(page: nowPage, size: 10), id: Diary.diaryId)
            }
            .onChange(of: isClick){
                if isClick{
                    Task{
                        await vm.postComment(comment: inputText,diaryId:Diary.diaryId)
                        inputText = ""
                        await vm.getCommentDiary(pageRequest: PageRequest(page: nowPage, size: 10), id: Diary.diaryId)

                    }
                }
            }
//            .onChange(of: subCommentBool){
//                if subCommentBool == true{
//                    Task{
//                        nowcommentPage = 1
//                        await vm.getSubCommentDiary(pageRequest: PageRequest(page: nowcommentPage, size: 10), parentId: parentIds )
//                    }
//                }
//            }
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
        } else {
            // Fallback on earlier versions
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
