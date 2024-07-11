//
//  OButton.swift
//  babya
//
//  Created by dgsw8th61 on 7/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct OButton : View {
    var body: some View {
        ZStack{
            Rectangle()
                .cornerRadius(10)
                .foregroundColor(Color.blue0)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.horizontal,15)
            
            Text("O")
                .foregroundStyle(.white)
                .font(.system(size: 20))
        }
    }
}

#Preview {
    OButton()
}
