//
//  UserDetailDiaryView.swift
//  babya
//
//  Created by dgsw8th61 on 6/6/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct UserDetailDiaryView : View {
    @GestureState private var dragOffset = CGSize.zero
    var Diary : DiaryResponse
    @State var inputText : String = ""
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var nowPage : Int = 1
    @State var isClick : Bool = false
    @StateObject var vm : DiaryViewModel
    @State var postSubComment : Bool = false
    @State var parentCommentId : Int = 0
    @State var nowcommentPage : Int = 1
    @State var subcommentList = [SubCommentResponse]()
    @State var loding : Bool = false
    var body: some View {
        if #available(iOS 17.0, *) {
            NavigationView{
                VStack(alignment: .leading){
                    ScrollView{
                        VStack{
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
                            
                            VStack(alignment: .leading ,spacing: 15){
                                HStack{
                                    VStack(alignment: .leading ,spacing: 10){
                                        HStack(spacing:7){
                                            Text("체중:")
                                                .font(.system(size: 13))
                                            TextLineStyle(text:String( Diary.weight))
                                            
                                            Text("kg")
                                                .font(.system(size: 13))
                                                .padding(.trailing,30)
                                            
                                            Text("임신주수:")
                                                .font(.system(size: 13))
                                            TextLineStyle(text: String(Diary.pregnancyWeeks))
                                            Text("주")
                                                .font(.system(size: 13))
                                        }
                                        HStack(spacing:7){
                                            Text("혈압:")
                                                .font(.system(size: 13))
                                            TextLineStyle(text: String(Diary.systolicPressure))
                                            Text("/")
                                                .font(.system(size: 13))
                                            TextLineStyle(text: String(Diary.diastolicPressure))
                                                .padding(.trailing,14)
                                            
                                            Text("다음 진찰일:")
                                                .font(.system(size: 13))
                                            Text(Diary.nextAppointment)
                                                .font(.system(size: 13))
                                        }
                                    }
                                    Spacer()
                                    VStack(spacing: 5) {
                                        if let emotion = Emotion.allCases.first(where: { $0.label == Diary.emojiCode }) {
                                            Image(emotion.rawValue)
                                                .resizable()
                                                .frame(width: 45, height: 45)
                                            Text(emotion.label)
                                                .font(.system(size: 12))
                                        } else {
                                            Text("Unknown Emotion")
                                                .font(.system(size: 12))
                                        }
                                    }
                                }
                                
                                Text("태아소견")
                                    .font(.system(size: 16))
                                    .bold()
                                
                                Text(Diary.fetusComment)
                                    .font(.system(size: 12))
                                    .multilineTextAlignment(.leading)
                                
                                Text("내용")
                                    .font(.system(size: 16))
                                    .bold()
                                    .padding(.top,5)
                                
                                
                                Text(Diary.content)
                                    .font(.system(size: 12))
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.horizontal,20)
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
            .navigationBarBackButtonHidden()
            .navigationTitle(Diary.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                toolbarContent()
            }
            .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
                if (value.startLocation.x < 30 && value.translation.width > 100) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        } else {
            //
        }
    }
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
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
                //                DiaryWritingView(title: PostName ,PostName: PostName ,DiaryImage: DiaryImage, vm: DiaryViewModel(diaryService: RemoteDiaryService()))
            } label: {
                Image("dots")
                    .resizable()
                    .frame(width: 18)
            }
        }
    }
    
}
