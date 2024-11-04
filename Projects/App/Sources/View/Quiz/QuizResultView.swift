//
//  QuizResultView.swift
//  babya
//
//  Created by dgsw8th61 on 7/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI
import FlowKit

struct QuizResultiew : View {
    let quizCn : String
    let answer : String
    let quizTitle: String
    var selected : String
    @Flow var flow
    
    var body: some View {
        VStack(alignment: .center){
            Text("일일퀴즈")
                .font(.system(size: 16,weight: .medium))
                .foregroundStyle(.black)
                .padding(.vertical,10)
            
            Divider()
            
            Text("Q.\(quizTitle)")
                .font(.system(size: 20,weight:.bold))
                .foregroundStyle(.black)
                .padding(.vertical,25)
                .padding(.horizontal,7)
            
            Image("quizIcon")
                .resizable()
                .scaledToFit()
                .aspectRatio(6/3.3, contentMode: .fit)
                .padding(.bottom,35)
            VStack(alignment: .leading){
                HStack{
                    if  answer == selected{
                        Text("정답입니다!")
                            .font(.system(size: 20,weight: .medium))
                            .foregroundStyle(Color.StatusPositive)
                    }else{
                        Text("오답입니다!")
                            .font(.system(size: 20,weight: .medium))
                            .foregroundStyle(Color.StatusDestructive)
                    }
                    Spacer()
                }
                
                Text(quizCn)
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                    .padding(.vertical,15)
            }
            .padding(.horizontal,15)
            
            Spacer()

            Button{
                flow.push(HomeView())
            }label: {
                BackButton()
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
    }
}
