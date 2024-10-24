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
    @Binding var postSubComment : Bool
    @Binding var parentCommentId : Int
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    HStack(spacing: 2){
                        Image(Comment.profileImg ?? "baseProfile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(minWidth: 25,maxHeight: 25)
                            .padding(.trailing,6)
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
                        postSubComment = true
                        parentCommentId = Comment.commentId
                        print(postSubComment)
                    } label: {
                        Text("답글달기")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.gray2)
                            .padding(.vertical,1)
                            .padding(.leading,25)
                    }
                }
                Spacer()
            }
            .padding(.top,3)
            
        }
    }
}


