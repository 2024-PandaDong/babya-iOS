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
                    HStack{
                        Image("arrow")
                        
                    }
                    HStack(spacing: 23) {
                        ZStack {
                            Button(action: {
                                Diary = true
                            }, label: {
                                Text("공개")
                                    .font(.system(size: 16,weight: .semibold))
                                    .foregroundStyle(.black)
                            })
                            .disabled(Diary)
                            .padding(.bottom,5)

                            if Diary {
                                Rectangle()
                                    .frame(width:42 ,height: 1.5)
                                    .foregroundColor(Color.PrimaryNormal)
                                    .padding(.top, 20)
                                    .edgesIgnoringSafeArea(.all)
                            }
                        }

                        ZStack {
                            Button(action: {
                                Diary = false
                            }, label: {
                                Text("비공개")
                                    .font(.system(size: 16,weight: .semibold))
                                    .foregroundStyle(.black)
                            })
                            .disabled(!Diary)
                            .padding(.bottom,5)
                            
                            if !Diary {
                                Rectangle()
                                    .frame(width:42 ,height: 1.5)
                                    .foregroundColor(Color.PrimaryNormal)
                                    .padding(.top, 20)
                                    .edgesIgnoringSafeArea(.all)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical,5)
                    .padding(.horizontal,23)
                    
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
                                        DiaryCeil(ProfileImage:vm.diaryList[count].files.first??.url ?? "baseProfile", Title: vm.diaryList[count].title, UserName: vm.diaryList[count].nickname ?? "알수없는사용자",Date: vm.diaryList[count].writtenDt)
                                            .padding(.vertical, 9)
                                            .padding(.horizontal,10)
                                            .onAppear{
                                                print("카운트 :: \(count)")
                                                if count % 10 == 9 {
                                                    nowPage += 1
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
                                    .frame(width: 180)
                                    .padding(.top,50)
                                
                                
                                Text("산모일기가 존재하지 않아요.")
                                    .font(.system(size: 20, weight: .bold))
                            }
                        }
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
//                .toolbar{
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        Button {
//                            self.presentationMode.wrappedValue.dismiss()
//                        } label: {
//                            Image("arrow")
//                                .resizable()
//                                .frame(width: 18,height: 18)
//                        }
//                    }
//                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        PencilButton()
                            .padding()
                    }
                }
            }
            .onChange(of: Diary) { value in
                nowPage = 1
                Task {
                    if Diary {
                        await vm.getListDiary(pageRequest: PageRequest(page: nowPage, size: 10))

                    }else {
                        await vm.getNDiary(pageRequest: PageRequest(page: nowPage, size: 10), email: LoginUserHashCache.shared.checkEmail() ?? "")
                        
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
        }
        .navigationBarBackButtonHidden()
    }
}
