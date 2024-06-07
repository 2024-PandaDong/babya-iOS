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
                        .font(.system(size: 17))
                    Text(Days)
                        .font(.system(size: 11))
                }
                Text(Content)
                    .padding(.leading,25)
            }
            .padding(.horizontal,10)
            Spacer()
        }
    }
}
