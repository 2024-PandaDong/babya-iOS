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
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                HStack(spacing: 2){
                    Image("Image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(minWidth: 25,maxHeight: 25 )
                    Text("유저이름")
                        .font(.system(size: 17))
                    Text("1일")
                        .font(.system(size: 11))
                }
                Text("댓글 내용~")
                    .padding(.leading,25)
            }
            .padding(.horizontal,10)
            Spacer()
        }
    }
}

#Preview {
    CommentCeil()
}
