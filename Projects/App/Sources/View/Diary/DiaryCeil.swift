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
    var body: some View {
        VStack(alignment: .leading,spacing: 6){
            Image("Image")
                .resizable()
                .frame(width: 166,height: 103)
                
            Text("동바오 첫 돌")
                .bold()
                .font(.system(size: 16))
            
            Text("유저이름")
                .font(.system(size: 13))
                .foregroundColor(.gray)

        }
        .padding(.horizontal,35)
    }
}
#Preview {
    DiaryCeil()
}
