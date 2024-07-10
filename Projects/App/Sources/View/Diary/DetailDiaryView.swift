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
    @State var postSubComment : Bool = false
    @State var parentCommentId : Int = 0
    @State var subcommentList = [SubCommentResponse]()
    @State var Second : Bool = false    
    var body: some View {
        if #available(iOS 17.0, *) {
            NavigationView{
                VStack(alignment: .leading){
                    ScrollView(showsIndicators: false){
                        VStack(alignment: .leading){
                            if let fileImage = Diary.files.first??.url,let imageUrl = URL(string: fileImage){
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .cornerRadius(10)
                                .padding(.horizontal,15)
                            }

                        
                            
                            
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
                                    CommentCeil(Comment: vm.comment[count], postSubComment: $postSubComment, parentCommentId: $parentCommentId)
                                        .padding(.vertical,5)
                                        .onAppear{
                                            if count == 9 {
                                                nowPage += 1
                                                print("page :: \(nowPage)")
                                            }
                                            print("count : \(count)")
                                            
                                        }
                                    if vm.comment[count].subCommentCnt != 0 && vm.Load {
                                        ForEach(((count != 0) && (vm.comment[count - 1].subCommentCnt != 0) ? (vm.comment[count - 1].subCommentCnt - 1) : 0)..<vm.subcommentcount, id: \.self) { index in
                                            SubCommentCeil(ProfileImage: subcommentList[index].profileImg ?? "Image",
                                                           UserName: subcommentList[index].nickname,
                                                           Days: subcommentList[index].createdAt,
                                                           Content: subcommentList[index].content)
                                            .padding(.leading, 10)
                                            .onAppear {
                                                if index == 9 {
                                                    nowcommentPage += 1
                                                    print("page :: \(nowcommentPage)")
                                                }
                                                
                                                print("index : \(index)")
                                                print("각각답글수 : \(vm.comment[count].subCommentCnt)")
                                                print("답글 수 : \(vm.subcommentcount)")
                                            }
                                        }
                                    }
                                    Divider()
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
            .onAppear{
                Task{
                    nowPage = 1
                    await vm.getCommentDiary(pageRequest: PageRequest(page: nowPage, size: 10), id: Diary.diaryId)
                    subcommentList = vm.subcomment
                }
            }
            .onChange(of: isClick){
                if isClick{
                    vm.commentcount = 0
                    vm.subcommentcount = 0
                    vm.subcomment = []
                    Task{
                        await vm.postComment(comment: inputText,diaryId:Diary.diaryId, parentCommentId: postSubComment ? parentCommentId : 0)
                        inputText = ""
                        await vm.getCommentDiary(pageRequest: PageRequest(page: nowPage, size: 10), id: Diary.diaryId)
                        postSubComment = false
                        subcommentList = vm.subcomment
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
