//
//  TextField.swift
//  babya
//
//  Created by dgsw8th61 on 6/4/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct TextfieldStyle: TextFieldStyle {
    @Binding var isClick : Bool 
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack{
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(height: 52)
                
                configuration
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .padding()
            }
            Button(action: {
                isClick = true
            }, label: {
                ZStack{
                   Rectangle()
                        .frame(width: 52,height: 52)
                        .foregroundColor(.yellow)
                    Image("Send")
                }
            })
        }
    }
}
