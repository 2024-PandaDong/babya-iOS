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
    @State private var showOverlay = false
    
    var body: some View {
        if #available(iOS 17.0, *) {
            ZStack{
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
                                Text(Diary.title)
                                    .font(.system(size: 16,weight: .medium))
                                    .foregroundStyle(Color.black)
//                                    .padding(.vertical,9)
                                    .padding(.horizontal,15)
                                
                                HStack{
                                    Text(Diary.nickname ?? "알 수 없는 사용자")
                                        .font(.system(size: 11))
                                        .foregroundStyle(.gray)
                    
                                    Spacer()
                                    Text(Diary.writtenDt)
                                        .font(.system(size: 11))
                                        .foregroundStyle(.gray)
                                      
                                }
                                .padding(.horizontal,15)
                                .padding(.vertical,5)
                                
                                if Diary.isPublic == "N"{
                                    
                                    VStack(alignment: .leading ,spacing: 15){
                                        HStack{
                                            VStack(alignment: .center,spacing: 5) {
                                                if let emotion = Emotion.allCases.first(where: { $0.label == Diary.emojiCode }) {
                                                    Image(emotion.rawValue)
                                                        .resizable()
                                                        .frame(width: 35, height: 35)
                                                    Text(emotion.label)
                                                        .font(.system(size: 12))
                                                } else {
                                                    Text("Unknown Emotion")
                                                        .font(.system(size: 12))
                                                }
                                            }
                                            Spacer()
                            
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
                        
                                        }
        
                                        Text("태아소견")
                                            .font(.system(size: 16))
                                            .bold()
                                        
                                        Text(Diary.fetusComment)
                                            .font(.system(size: 12))
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.horizontal,15)
                                    .padding(.vertical,10)
                                }
                                
//                                TextTitleStyle(Title: Text("본문"))
//                                    .padding(.vertical,7)
                                
                                TextContentStyle(content: Text(Diary.content))
                                    .padding(.bottom,10)
                                Divider()
                                
                                ScrollView(showsIndicators: false) {
                                    ForEach((0..<vm.commentcount), id: \.self) { count in
                                        CommentCeil(Comment: vm.comment[count], postSubComment: $postSubComment, parentCommentId: $parentCommentId)
                                            .padding(.leading, 10)
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
                                TextField("댓글쓰기", text: $inputText)
                                    .textFieldStyle(TextfieldStyle(isClick: $isClick))
                                
                            }
                        }
                    }
                }
                .alert("해당 산모일기를 신고하겠습니까?", isPresented: $showOverlay) {
                    Button("신고", role: .destructive) {
                        Task{
                            print(Diary.diaryId)
                            await vm.report(id:Diary.diaryId)
                        }
                    }
                    Button("취소", role: .cancel) {}
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
            }
            //do : 대댓글 페이징 처리
            .navigationBarBackButtonHidden()
//            .navigationTitle(Diary.title)
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
                        showOverlay.toggle()
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
            .font(.system(size: 14))
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
