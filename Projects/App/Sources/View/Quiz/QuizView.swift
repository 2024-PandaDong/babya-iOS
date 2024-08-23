//
//  QuizView.swift
//  babya
//
//  Created by dgsw8th61 on 7/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

struct QuizView : View {
    @StateObject var vm : QuizViewModel
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
                .padding(.vertical,25)
                .padding(.horizontal,7)
            
            Image("quizIcon")
                .resizable()
                .scaledToFit()
                .aspectRatio(6/3.3, contentMode: .fit)
                .padding(.vertical,35)
            
            Spacer()

            VStack(alignment: .center, spacing: 15){
                NavigationLink(destination: QuizResultiew(quizCn: vm.quizList?.quizCn ?? "", answer: vm.quizList?.answer ?? "", quizTitle: vm.quizList?.title ?? "")) {
                    OButton()
                }
                NavigationLink(destination: QuizResultiew(quizCn: vm.quizList?.quizCn ?? "", answer: vm.quizList?.answer ?? "", quizTitle: vm.quizList?.title ?? "")) {
                    XButton()
                }
            }
            
            NavigationLink(destination: HomeView()) {
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
    }
}
