//
//  LineTextField.swift
//  babya
//
//  Created by dgsw8th61 on 6/6/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct LineTextField: View {
    @Binding var text: String
    var TextFieldWidth : CGFloat
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        TextField("", text: $text)
            .frame(width: TextFieldWidth)
            .font(.system(size: 14))
            .focused($isTextFieldFocused)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isTextFieldFocused = true
                }
            }
            .overlay(
                GeometryReader { geometry in
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        path.move(to: CGPoint(x: 0, y: height))
                        path.addLine(to: CGPoint(x: width, y: height))
                    }
                    .stroke(Color.primary, lineWidth: 0.5)
                }
                    .frame(height: 1), alignment: .bottom
            )
    }
}

