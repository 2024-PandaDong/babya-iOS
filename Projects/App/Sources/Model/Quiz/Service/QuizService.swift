//
//  QuizService.swift
//  babya
//
//  Created by dgsw8th61 on 7/10/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import UIKit

protocol QuizService {
    func getQuiz() async throws -> Response<QuizResponse>
    
}
