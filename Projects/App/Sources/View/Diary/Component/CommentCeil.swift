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
                        .frame(minWidth: 25,maxHeight: 25)
                    Text(UserName)
                        .font(.system(size: 13))
                        .foregroundStyle(.black)
                    Text(Days)
                        .font(.system(size: 11))
                        .foregroundStyle(Color.gray2)
                }
                Text(Content)
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
    }
}

#Preview {
    CommentCeil(ProfileImage: "Image", UserName: "dldbs", Days: "1일", Content: "집에 가고 싶다.")
}
