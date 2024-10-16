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
    @State var nowcommentPage : Int = 1
    @State var subresponse = [SubCommentResponse]()
    @State var isClick : Bool = false
    @State var postSubComment : Bool = false
    @State var parentCommentId : Int = 0
    @State var subcommentList = [SubCommentResponse]()
    @State var loding : Bool = false
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
                                    if vm.comment[count].subCommentCnt != 0 && loding {
                                        let cnt = (count != 0) ? subcommentList.count : vm.comment[count].subCommentCnt
                                        let aa = (count != 0) && (vm.comment[count - 1].subCommentCnt != 0) ? (vm.comment[count - 1].subCommentCnt) : 0
                                        ForEach(aa..<cnt , id: \.self) { index in
                                            SubCommentCeil(ProfileImage: subcommentList[index].profileImg ?? "baseProfile",
                                                           UserName: subcommentList[index].nickname,
                                                           Days: subcommentList[index].createdAt,
                                                           Content: subcommentList[index].content)
                                            .padding(.leading, 10)
                                            .onAppear {
                                                if index % 10 == 9 {
                                                    nowcommentPage += 1
                                                    print("page :: \(nowcommentPage)")
                                                }
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
                            Image("baseProfile")
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
                    await vm.getCommentDiary(pageRequest: PageRequest(page: nowPage, size: 50), id: Diary.diaryId)
                    subcommentList = vm.subcomment
                    loding = true
                }
            }
            .onChange(of: isClick){
                if isClick{
                    if postSubComment{
                        vm.subcommentcount = 0
                        vm.subcomment = []
                    }else{
                        vm.commentcount = 0
                    }
                    Task{
                        loding = false
                        await vm.postComment(comment: inputText,diaryId:Diary.diaryId, parentCommentId: postSubComment ? parentCommentId : 0)
                        inputText = ""
                        await vm.getCommentDiary(pageRequest: PageRequest(page: nowPage, size: 50), id: Diary.diaryId)
                        if postSubComment{
                            subcommentList = vm.subcomment
                        }
                        postSubComment = false
                        loding = true
                    }
                }
            }
            //do : 대댓글 페이징 처리
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
