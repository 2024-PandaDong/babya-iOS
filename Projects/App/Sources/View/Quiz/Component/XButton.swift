//
//  QuizView.swift
//  babya
//
//  Created by dgsw8th61 on 7/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct XButton : View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(Color.Red60)
                .frame(maxWidth: .infinity)
                .frame(height: 43)
                .padding(.horizontal,15)
            
            Text("X")
                .foregroundStyle(.white)
                .font(.system(size: 20))
        }
    }
}

#Preview {
    XButton()
}
