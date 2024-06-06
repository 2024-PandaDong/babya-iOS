//
//  DiaryCeil.swift
//  babya
//
//  Created by dgsw8th61 on 5/23/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import SwiftUI

struct DiaryCeil : View {
    var ProfileImage : String
    var Title : String
    var UserName : String
    var body: some View {
        VStack(alignment: .leading,spacing: 6){
            Image(ProfileImage)
                .resizable()
                .frame(width: 166,height: 103)
                
            Text(Title)
                .bold()
                .font(.system(size: 16))
                .foregroundStyle(.black)
            
            Text(UserName)
                .font(.system(size: 13))
                .foregroundStyle(.gray)

        }
        .padding(.horizontal,35)
    }
}

