//
//  SubCommentCeil.swift
//  babya
//
//  Created by dgsw8th61 on 6/24/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import SwiftUI

struct SubCommentCeil : View {
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
                
                Divider()
                    .padding(.vertical,1)
            }
            Spacer()
        }
        .padding(.top,3)
    }
}


