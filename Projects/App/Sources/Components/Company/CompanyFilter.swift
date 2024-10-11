//
//  CompaneyFilter.swift
//  babya
//
//  Created by dgsw8th61 on 8/28/24.
//

import SwiftUI

struct CompanyFilter : View {
    var title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 58, height: 25)
            .foregroundStyle(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(Color.LabelDisable)
                HStack{
                    Text(title)
                        .foregroundStyle(Color.black)
                        .font(.system(size: 14))
                    Image("Vector")
                        .resizable()
                        .frame(width: 5,height: 2.5)
                }
            }
    }
}

#Preview {
    CompaneyFilter(title: "지역")
}
