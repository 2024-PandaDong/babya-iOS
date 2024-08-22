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
            destination: DiaryWritingView(title: "test", PostName: "test", DiaryImage: "Image", vm: DiaryViewModel(diaryService: RemoteDiaryService())),
            label: {
                Circle()
                    .foregroundColor(.PrimaryLight)
                    .frame(width: 50,height: 50)
                    .overlay{
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                    }
            })
    }
}
#Preview {
    PencilButton()
}
