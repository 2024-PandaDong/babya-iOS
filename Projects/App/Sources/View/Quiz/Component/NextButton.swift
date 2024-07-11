//
//  NextButton.swift
//  babya
//
//  Created by dgsw8th61 on 7/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct NextButton : View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(Color.yellow0)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.horizontal,15)
            
            Text("메인화면으로 가기")
                .foregroundStyle(.white)
                .font(.system(size: 20))
        }
    }
}
#Preview {
    NextButton()
}
