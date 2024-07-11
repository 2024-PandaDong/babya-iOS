//
//  QuizResultView.swift
//  babya
//
//  Created by dgsw8th61 on 7/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct QuizResultiew : View {
    let quizCn : String
    let answer : String
    var body: some View {
        NavigationView{
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
                
                HStack(spacing: 5){
                    Text("정답 : ")
                        .font(.system(size: 24))
                        .foregroundStyle(.black)
                    if  answer == "Y"{
                        Text("O")
                            .font(.system(size: 24))
                            .foregroundStyle(Color.green0)
                    }else{
                        Text("X")
                            .font(.system(size: 24))
                            .foregroundStyle(Color.red0)
                    }
                    Spacer()
                }
                .padding(.horizontal,15)
                
                Text(quizCn)
                    .font(.system(size: 18))
                    .foregroundStyle(.black)
                    .padding(.vertical,25)
                    .padding(.horizontal,10)
                
                Spacer()
                
                NavigationLink(destination: HomeView()) {
                    NextButton()
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

