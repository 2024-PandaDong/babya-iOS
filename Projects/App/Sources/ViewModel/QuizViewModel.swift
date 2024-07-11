//
//  QuizViewModel.swift
//  babya
//
//  Created by dgsw8th61 on 7/11/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Alamofire
import SwiftUI

@MainActor
class QuizViewModel: ObservableObject {
    @Published var quizList : QuizResponse?
    private let quizService: QuizService
    
    init(quizService: QuizService) {
        self.quizService = quizService
    }
    
    func getQuiz() async{
        do{
            let response = try await quizService.getQuiz()
            quizList = response.data ?? nil
            print(response)
        }catch{
            print(error)
        }
    }
}
