//
//  CommentCeil.swift
//  babya
//
//  Created by dgsw8th61 on 6/4/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import SwiftUI

struct CommentCeil : View {
    var Comment : CommentResponse
//    var subcomment = [SubCommentResponse]()
//    var isSub : Bool
    @State var nowcommentPage : Int = 1
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack(spacing: 2){
                        Image(Comment.profileImg ?? "Image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(minWidth: 25,maxHeight: 25)
                        Text(Comment.nickname)
                            .font(.system(size: 13))
                            .foregroundStyle(.black)
                        Text(Comment.createdAt)
                            .font(.system(size: 11))
                            .foregroundStyle(Color.gray2)
                    }
                    Text(Comment.content)
                        .padding(.leading,25)
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    
                    Button {
                        // 댓글 쓰기
                    } label: {
                        Text("답글달기")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.gray2)
                            .padding(.vertical,1)
                            .padding(.leading,25)
                    }
                    Divider()
                }
                Spacer()
            }
            .padding(.top,3)
            
//            if isSub{
                //                ForEach((0..<subcomment.count), id: \.self) { index in
                //                    SubCommentCeil(ProfileImage: subcomment[index].profileImg ?? "Image",
                //                                   UserName: subcomment[index].nickname,
                //                                   Days: subcomment[index].createdAt,
                //                                   Content: subcomment[index].content)
                //                    .padding(.leading, 10)
                //                    .onAppear {
                //                        if index == 9 {
                //                            nowcommentPage += 1
                //                            print("page :: \(nowcommentPage)")
                //                        }
                //                        print("index : \(index)")
                //                    }
                //                }
//            }
        }
    }
}


//#Preview {
//    CommentCeil(ProfileImage: "Image", UserName: "dldbs", Days: "1일", Content: "집에 가고 싶다.")
//}
