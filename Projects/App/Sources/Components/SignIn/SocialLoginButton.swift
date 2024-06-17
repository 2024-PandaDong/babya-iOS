//
//  SocialLoginButton.swift
//  babya
//
//  Created by dgsw8th61 on 5/16/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import SwiftUI

struct SocialLoginButton: View {
    let imageName: String
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .foregroundColor(backgroundColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .cornerRadius(30)
                
                HStack(spacing: 50) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 28, height: 28)
                    
                    Text(title)
                        .font(.system(size: 14))
                        .foregroundColor(textColor)
                }
            }
        }
        .padding(.vertical, 6)
    }
}
