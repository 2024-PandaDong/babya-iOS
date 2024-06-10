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
    var ProfileImage : String
    var UserName : String
    var Days : String
    var Content : String
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack(spacing: 2){
                    Image(ProfileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(minWidth: 25,maxHeight: 25 )
                    Text(UserName)
                        .font(.system(size: 13))
                    Text(Days)
                        .font(.system(size: 11))
                }
                Text(Content)
                    .padding(.leading,25)
                
                Button {
                    // 댓글 쓰기
                } label: {
                    Text("댓글쓰기")
                        .font(.system(size: 11))
                        .foregroundStyle(.gray)
                        .padding(.vertical,1)
                        .padding(.leading,25)
                }
                Divider()
            }
            .padding(.horizontal,10)
            Spacer()
        }
    }
}

#Preview {
    CommentCeil(ProfileImage: "Image", UserName: "dldbs", Days: "1일", Content: "집에 가고 싶다.")
}
