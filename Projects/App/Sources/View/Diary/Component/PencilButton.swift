//
//  PencilButton.swift
//  babya
//
//  Created by dgsw8th61 on 6/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct PencilButton : View {
    var body: some View {
        NavigationLink(
            destination: DiaryWritingView(title: "test", PostName: "test", DiaryImage: "Image"),
            label: {
                Circle()
                    .foregroundColor(.yellow0)
                    .frame(width: 50,height: 50)
                    .overlay{
                        Image("pencil")
                    }
            })
    }
}
#Preview {
    PencilButton()
}
