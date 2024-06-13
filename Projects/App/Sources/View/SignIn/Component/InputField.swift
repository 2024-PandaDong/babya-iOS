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
            Text(placeholder)
                .font(.system(size: 13))
                .padding(.top, 10)
                .foregroundColor(Color.gray1)

            HStack {
                if isSecure {
                    if showPassword {
                        TextField("", text: $securetext)
                    } else {
                        SecureField("", text: $securetext)
                    }
                } else {
                    TextField("", text: $text)
                }
                if isSecure {
                    Button {
                        self.showPassword.toggle()
                    } label: {
                        Image(systemName: "eye")
                            .resizable()
                            .frame(width: 15, height: 10)
                            .foregroundColor(.secondary)
                    }
                }
            }.underlineTextField()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.system(size: 13))
                    .foregroundColor(Color.red)
            }
        }
    }
}
