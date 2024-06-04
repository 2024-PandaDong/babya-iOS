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
    var DiaryImage : String
    var body: some View {
        VStack(alignment: .leading){
            Image("Image")
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(10)
                .padding(.horizontal,15)
            
            TextTitleStyle(Title: Text("태아소견"))
                .padding(.top,15)
    
            TextContentStyle(content: Text("잘 크고 있다."))
                .padding(.bottom,10)
            
            TextTitleStyle(Title: Text("내용"))
            
            TextContentStyle(content:  Text("aslk;dfjslkdjflsakjflsljks;dajsld"))
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
}
#Preview {
    DetailDiaryView(inputText: "", DiaryImage: "")
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
