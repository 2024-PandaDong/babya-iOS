//
//  IconButtons.swift
//  babya
//
//  Created by dgsw8th61 on 6/8/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import SwiftUI

enum Emotion: String, CaseIterable {
    case happy = "좋음 이모티콘"
    case normal = "평범 이모티콘"
    case pain = "아픔 이모티콘"
    case tired = "피곤 이모티콘"
    case anxious = "불안 이모티콘"
    
    var label: String {
        switch self {
        case .happy:
            return "좋음"
        case .normal:
            return "평범"
        case .pain:
            return "아픔"
        case .tired:
            return "피곤"
        case .anxious:
            return "불안"
        }
    }
}

struct IconButtons: View {
    var emotion: Emotion
    var isSelected: Bool
    var onSelect: (Emotion) -> Void
    
    var body: some View {
        Button(action: {
            onSelect(emotion)
        }, label: {
            VStack(spacing: 5) {
                Image(emotion.rawValue)
                    .resizable()
                    .frame(width: 45, height: 45)
                Text(emotion.label)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
            }
            .opacity(isSelected ? 1 : 0.3)
        })
    }
}
