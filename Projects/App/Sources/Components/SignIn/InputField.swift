//
//  InputField.swift
//  babya
//
//  Created by dgsw8th61 on 5/16/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//
import Foundation
import SwiftUI

struct InputFieldView: View {
    @Binding var text: String
    @Binding var securetext: String
    @Binding var showPassword: Bool
    var errorMessage: String?
    var placeholder: String
    var isSecure: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isSecure {
                    if showPassword {
                        TextField(placeholder, text: $securetext)
                            .customTextField()

                     
                    } else {
                        SecureField(placeholder, text: $securetext)
                            .customTextField()

                    }
                } else {
                    TextField(placeholder, text: $text)
                        .customTextField()

                }
            }
            .textInputAutocapitalization(.never)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundColor(Color.red)
            }
        }
    }
}

extension View {
    func customTextField() -> some View {
        self
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.LineAlternative, lineWidth: 1.5)
            )
    }
}
