//
//  QuizView.swift
//  babya
//
//  Created by dgsw8th61 on 7/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI
import FlowKit

struct QuizView : View {
    @StateObject var vm : QuizViewModel
    @Flow var flow
    var body: some View {
        VStack(alignment: .center){
            Text("일일퀴즈")
                .font(.system(size: 16,weight: .medium))
                .foregroundStyle(.black)
                .padding(.vertical,10)
            
            Divider()
            
            Text("Q." + (vm.quizList?.title ?? ""))
                .font(.system(size: 20,weight:.bold))
                .foregroundStyle(.black)
                .padding(.top,25)
                .padding(.horizontal,7)
            
            Text("출처: 도서 '아기 100일 엄마 100일'")
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.LabelLightDisable)
                .padding(.vertical, 10)
            
            Image("quizIcon")
                .resizable()
                .scaledToFit()
                .aspectRatio(6/3.3, contentMode: .fit)
                .padding(.vertical,35)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 15){
                Button {
                    flow.push(QuizResultiew(quizCn: vm.quizList?.quizCn ?? "",
                                            answer: vm.quizList?.answer ?? "",
                                            quizTitle: vm.quizList?.title ?? "",
                                            selected: "Y"),animated: false)
                } label: {
                    OButton()
                }
                Button{
                    flow.push(QuizResultiew(quizCn: vm.quizList?.quizCn ?? "",
                                            answer: vm.quizList?.answer ?? "",
                                            quizTitle: vm.quizList?.title ?? "",
                                            selected: "N"),animated: false)
                } label: {
                    XButton()
                }
            }

            Button {
                flow.replace([HomeView()], animated: false)

            } label: {
                Text("건너뛰기")
                    .foregroundColor(Color.LabelAssistive)
                    .font(.system(size: 16))
                    .padding(.top,5)
            }
        }
        .padding(.horizontal,5)
        .task {
            await vm.getQuiz()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}
