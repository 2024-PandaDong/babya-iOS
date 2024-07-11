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
    @StateObject var vm : DiaryViewModel
    let columns = [GridItem(.fixed(180)),
                   GridItem(.fixed(180))]
    @State var All : Bool = true
    @State var myDiary : Bool = false
    @State var Diary : Bool = true
    @State var nowPage : Int = 1
    @State private var diaryComment: [DiaryCommentResponse] = []
    @FocusState private var isTextFieldFocused: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var fetchDiary : Bool = false
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
                    ScrollView(showsIndicators: false) {
                        if vm.diarycount != 0 {
                            LazyVGrid(columns: columns) {
                                ForEach((0..<vm.diarycount), id: \.self) { count in
                                    NavigationLink(
                                        destination: {
                                            if All {
                                                DetailDiaryView(vm: DiaryViewModel(diaryService: RemoteDiaryService()), Diary: vm.diaryList[count])
                                                    
                                            } else {
                                                UserDetailDiaryView(Diary: vm.diaryList[count], vm:DiaryViewModel(diaryService: RemoteDiaryService()))
                                            }
                                        })
                                    {
                                        DiaryCeil(ProfileImage:vm.diaryList[count].files.first??.url ?? "baseProfile", Title: vm.diaryList[count].title, UserName: vm.diaryList[count].nickname)
                                            .padding(.vertical, 5)
                                            .onAppear{
                                                print("카운트 :: \(count)")
                                                if count % 10 == 9 {
                                                    nowPage += 1
                                                    print("page :: \(nowPage)")
                                                }
                                            }
                                    }
                                }
                            }
                        } else {
                            VStack {
                                Image("baseDiaryImage")
                                    .resizable()
                                    .scaledToFit()
                                
                                Text("산모일기가 존재하지 않아요.")
                                    .font(.system(size: 20, weight: .bold))
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
                            self.presentationMode.wrappedValue.dismiss()
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
            .task {
                nowPage = 1
                await vm.getListDiary(pageRequest: PageRequest(page: nowPage, size: 10))
            }
            .onChange(of: nowPage, perform: { value in
                if All {
                    Task{
                        await vm.fetchListDiary(pageRequest:PageRequest(page: nowPage, size: 10))
                    }
                }else{
                    Task{
                        await vm.fetchDiary(pageRequest:PageRequest(page: nowPage, size: 10))
                    }
                }
            })
            .onChange(of: All, perform: { value in
                nowPage = 1
                Diary = true
                Task{
                    if All{
                        await vm.getListDiary(pageRequest: PageRequest(page: nowPage, size: 10))
                    }else {
                        await vm.getDiary(pageRequest: PageRequest(page: nowPage, size: 10), email: LoginUserHashCache.shared.checkEmail() ?? "")
                    }
                }
            })
            .onChange(of: Diary) { value in
                nowPage = 1
                Task {
                    if Diary {
                        await vm.getDiary(pageRequest: PageRequest(page: nowPage, size: 10), email: LoginUserHashCache.shared.checkEmail() ?? "")
                    }else {
                        await vm.getNDiary(pageRequest: PageRequest(page: nowPage, size: 10), email: LoginUserHashCache.shared.checkEmail() ?? "")
                        
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
