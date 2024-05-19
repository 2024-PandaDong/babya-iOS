//
//  SignUpTextField.swift
//  babya
//
//  Created by dgsw8th32 on 5/2/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct SignUpTextField: View {
    @StateObject var vm = SignUpViewModel()
    
    let title: String
    @Binding var content: String
    let placeholder: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            
            TextField("", text: $content, prompt: Text(placeholder).font(.system(size: 14, weight: .semibold)))
                .tint(.yellow)
                .textInputAutocapitalization(.never)
                .onSubmit {
                    print(content)
                }
            
            Rectangle()
                .frame(width: 330, height: 1)
                .foregroundStyle(Color(red: 203/255, green: 203/255, blue: 203/255))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 5)
    }
}

#Preview {
    SignUpTextField(title: "", content: .constant(""), placeholder: "") {
        
    }
}
