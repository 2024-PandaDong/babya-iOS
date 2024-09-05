//
//  NextButton.swift
//  babya
//
//  Created by dgsw8th61 on 7/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct BackButton : View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(Color.PrimaryLight)
                .frame(maxWidth: .infinity)
                .frame(height: 43)
                .padding(.horizontal,15)
            
            Text("넘어가기")
                .foregroundStyle(.white)
                .font(.system(size: 16,weight: .medium))
        }
    }
}
#Preview {
    BackButton()
}
