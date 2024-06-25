//
//  UserDetailDiaryView.swift
//  babya
//
//  Created by dgsw8th61 on 6/6/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct UserDetailDiaryView : View {
    var Diary : DiaryResponse
    @State var inputText : String = ""
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var nowPage : Int = 1
    @StateObject var vm : DiaryViewModel
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                ScrollView{
                    VStack{
                        Image(Diary.files.first??.url ?? "Image")
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
                            ForEach(0..<vm.commentcount, id: \.self) { index in
                                CommentCeil(Comment:vm.comment[index])
                                    .padding(.vertical,5)
                                    .onAppear{
                                        if index == 9 {
                                            nowPage += 1
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
            toolbarContent()
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

//#Preview {
//    UserDetailDiaryView(PostName: "포스트이름", DiaryImage: "Image")
//}
