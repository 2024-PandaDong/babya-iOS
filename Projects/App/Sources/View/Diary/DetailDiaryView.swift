//
//  DetailDiaryView.swift
//  babya
//
//  Created by dgsw8th61 on 6/4/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct DetailDiaryView : View {
    @State var inputText : String
    var body: some View {
        VStack{
            HStack(spacing: 1){
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(minWidth: 25,maxHeight: 25)
                
                TextField("댓글달기", text: $inputText)
                    .textFieldStyle(TextfieldStyle())
            }
        }
    }
}
#Preview {
    DetailDiaryView(inputText: "")
}
