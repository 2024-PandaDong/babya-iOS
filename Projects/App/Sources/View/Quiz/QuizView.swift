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
        NavigationView{
            VStack(alignment: .center){
                Text("일일퀴즈")
                    .font(.system(size: 24,weight:.bold))
                    .foregroundStyle(.black)
                    .padding(.bottom,50)
                
                Text("Q." + (vm.quizList?.title ?? ""))
                    .font(.system(size: 24,weight:.bold))
                    .foregroundStyle(.black)
                    .padding(.bottom,35)
                    .padding(.horizontal)
                
                Image("quizIcon")
                    .resizable()
                    .aspectRatio(6/4, contentMode: .fit)
                    .padding(.bottom,35)
                
                VStack(alignment: .center, spacing: 35){
                    NavigationLink(destination: QuizResultiew(quizCn: vm.quizList?.quizCn ?? "", answer: vm.quizList?.answer ?? "", quizTitle: vm.quizList?.title ?? "")) {
                        OButton()
                    }
                    NavigationLink(destination: QuizResultiew(quizCn: vm.quizList?.quizCn ?? "", answer: vm.quizList?.answer ?? "", quizTitle: vm.quizList?.title ?? "")) {
                        XButton()
                    }
                }
                
                NavigationLink(destination: HomeView()) {
                    Text("건너뛰기")
                        .foregroundColor(Color.gray3)
                        .font(.system(size: 20))
                        .padding(.top,45)
                }
                
                Spacer()
            }
            .padding(.horizontal,5)
            .task {
                await vm.getQuiz()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

