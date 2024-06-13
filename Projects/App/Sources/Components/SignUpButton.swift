//
//  SignUpButton.swift
//  babya
//
//  Created by dgsw8th32 on 5/11/24.
//

import SwiftUI

struct SignUpButton: View {
    let isAvailable: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
           action()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 340, height: 50)
                .foregroundStyle(isAvailable ? Color(red: 255/255, green: 203/255, blue: 41/255) : .gray)
                .overlay {
                    Text("회원가입")
                        .foregroundStyle(.white)
                        .font(.system(size: 15, weight: .bold))
                }
        }
        .padding(.bottom, 50)
        .disabled(!isAvailable)
    }
}

#Preview {
    SignUpButton(isAvailable: false) {
        
    }
}
