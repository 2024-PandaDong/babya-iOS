//
//  SignUpTextField.swift
//  babya
//
//  Created by dgsw8th32 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct SignUpTextField: View {
    
    @Binding var content: String
    let placeholder: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(maxWidth: .infinity, minHeight: 55, maxHeight: 55)
            .foregroundStyle(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.LineAlternative)
                
                HStack(alignment: .center) {
                    VStack {
                        TextField("", text: $content, prompt: Text(placeholder).font(.system(size: 16, weight: .semibold)))
                            .frame(width: 230)
                            .tint(Color.PrimaryNormal)
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
            }
    }
}

#Preview {
    SignUpTextField(content: .constant(""), placeholder: "안녕안녕")
}
