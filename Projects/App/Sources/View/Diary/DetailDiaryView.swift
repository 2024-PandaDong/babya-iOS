//
//  DetailDiaryView.swift
//  babya
//
//  Created by dgsw8th61 on 6/4/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct DetailDiaryView : View {
    @State var inputText : String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var DiaryImage : String
    var Opinion : String
    var Content : String
    var PostName : String
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Image(DiaryImage)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .padding(.horizontal,15)
                
                TextTitleStyle(Title: Text("태아소견"))
                    .padding(.top,15)
                
                TextContentStyle(content: Text(Opinion))
                    .padding(.bottom,10)
                
                TextTitleStyle(Title: Text("내용"))
                
                TextContentStyle(content:  Text(Content))
                HStack{
                    Spacer()
                    Text("2024/01/23")
                        .font(.system(size: 11))
                        .foregroundStyle(.gray)
                        .padding(15)
                }
                Divider()
                    .padding(.horizontal,15)
                
                CommentCeil(ProfileImage: "Image", UserName: "유저이름", Days: "1일", Content: "내용내용")
                    .padding(.vertical,5)
                
                ZStack{
                    VStack{
                        Spacer()
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
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(PostName)
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
        }
    }
}
#Preview {
    DetailDiaryView(inputText: "", DiaryImage: "Image",Opinion: "잘 크고 있다.", Content: "내용내용",PostName: "게시물이름")
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
