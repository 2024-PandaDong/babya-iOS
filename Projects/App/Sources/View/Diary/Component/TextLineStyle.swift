//
//  TextLineStyle.swift
//  babya
//
//  Created by dgsw8th61 on 6/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct TextLineStyle : View {
    var text : String
    var body: some View {
        VStack{
            Text(text)
                .foregroundStyle(.black)
                .font(.system(size: 13))
                .overlay(
                    GeometryReader { geometry in
                        Path { path in
                            let width = geometry.size.width
                            let height = geometry.size.height
                            path.move(to: CGPoint(x: 0, y: height))
                            path.addLine(to: CGPoint(x: width, y: height))
                        }
                        .stroke(Color.black, lineWidth: 0.5)
                    }
                        .frame(height: 1), alignment: .bottom
                )
        }
    }
}
//#Preview {
//    TextLineStyle()
//}
