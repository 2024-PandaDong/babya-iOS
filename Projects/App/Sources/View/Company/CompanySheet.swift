//
//  CompanySheet.swift
//  babya
//
//  Created by dgsw8th61 on 9/4/24.
//

import SwiftUI

struct CompanySheet : View {
    @State private var clickedIndices = Array(repeating: false, count: 13)
    let region = ["대구광역시", "수원시", "인천광역시", "포항시", "대전광역시", "논산시",
                 "광주광역시","서울특별시","세종특별자치시","남양주시","울산광역시","공주시","부산광역시"]
    let county = ["동구","서구","남구","달성군","북구"]
    let residence = ["구지"]
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 7), count: 4)
        
        VStack(alignment: .leading,spacing: 25){
            Text("지역을 선택해주세요.")
                .font(.system(size: 16,weight: .semibold))
                .foregroundStyle(Color.black)
            LazyVGrid(columns: columns, spacing: 7) {
                ForEach(region.indices, id: \.self) { index in
                    Button {
                        clickedIndices[index].toggle()
                        print("클릭한 도시: \(region[index])")
                        
                    } label: {
                            Text(region[index])
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(clickedIndices[index] ? Color.PrimaryLight : Color.LabelDisable)
                                .padding(5)
                                .lineLimit(1)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(clickedIndices[index] ? Color.PrimaryLight : Color.LabelDisable, lineWidth: 1)
                                }
                    }
                }
            }
            Text("군을 선택해주세요.")
                .font(.system(size: 16,weight: .semibold))
                .foregroundStyle(Color.black)
            
            Text("거주 지역을 선택해주세요.")
                .font(.system(size: 16,weight: .semibold))
                .foregroundStyle(Color.black)
        }
        .padding(29)
        
        CompanyButton(content: "검색하기")
    }
}

#Preview {
    CompanySheet()
}
