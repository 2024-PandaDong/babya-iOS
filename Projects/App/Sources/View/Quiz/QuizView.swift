//
//  QuizView.swift
//  babya
//
//  Created by dgsw8th61 on 7/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct QuizView : View {
    @State var isTrue : Bool = false
    @State var isFalse : Bool = false
    var body: some View {
        VStack(alignment: .center){
            Text("일일퀴즈")
                .font(.system(size: 24,weight:.bold))
                .foregroundStyle(.black)
                .padding(.bottom,40)
               
            Text("Q.일일퀴즈 질문 내용 넣기")
                .font(.system(size: 24,weight:.bold))
                .foregroundStyle(.black)
                .padding(.bottom,35)
            
            Image("quizIcon")
                .resizable()
                .aspectRatio(6/4, contentMode: .fit)
                .padding(.bottom,35)
            
            VStack(alignment: .center, spacing: 35){
                Button(action: {}, label: {
                    OButton()
                })
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    XButton()
                })
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("건너뛰기")
                    .foregroundColor(Color.gray3)
                    .font(.system(size: 20))
                    .padding(.top,45)
            })
            
            Spacer()
        }
    }
}
#Preview {
    QuizView()
}
