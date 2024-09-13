//
//  CompaneyFilter.swift
//  babya
//
//  Created by dgsw8th61 on 8/28/24.
//

import SwiftUI

struct CompanyFilter : View {
    @State var isSelect: Bool
    var title: String
    
    var body: some View {
        //TODO: 버튼으로 변경하기
        Text(title)
            .font(.system(size: 14,weight: .medium))
            .foregroundColor(isSelect ? Color.PrimaryLight : Color.LabelDisable)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(.white)
            .cornerRadius(16)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(isSelect ? Color.PrimaryLight : Color.LabelDisable, lineWidth: 1)
            )
            .frame(height: 25)
    }
}

#Preview {
    CompanyFilter(isSelect: true, title: "지역")
}
