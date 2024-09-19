//
//  CompaneyCharts.swift
//  babya
//
//  Created by dgsw8th61 on 8/28/24.
//

import SwiftUI
import Charts

struct CompanyCharts: View {
    var data: [System]
    var salaries: [String]

    var body: some View {
        HStack(spacing: 10){
            let datas = [
                ("전체", salaries.indices.contains(0) ? salaries[0] : "N/A"),
                ("남성", salaries.indices.contains(1) ? salaries[1] : "N/A"),
                ("여성", salaries.indices.contains(2) ? salaries[2] : "N/A")
            ]
            ForEach(datas, id: \.0) { item in
                VStack(spacing: 12){
                    Text(item.0)
                        .font(.system(size:14,weight: .semibold ))
                    
                    Text(item.1)
                        .font(.system(size:14,weight: .semibold ))
                    
                }
            }
            
            Spacer()
            
            Chart(data, id: \.version) { element in
                SectorMark(
                    angle: .value("Usage", element.count),
                    innerRadius: .ratio(0.45)
                )
                .foregroundStyle(by: .value("Version", element.colors))
                
            }
            .chartLegend(alignment: .center)
            .frame(width: 100,height: 100)
            .chartLegend(.hidden)
            .scaledToFit()
            .chartForegroundStyleScale([
                "pink": Color.pink70,
                "blue": Color.blue70
            ])
            
        }
    }
}

struct System {
    let version: String
    let count: Int
    let colors: String
    
    static func dummyData(salaries: [String]) -> [System] {
        let totalCount = 100
        
        let malePercentage = salaries.indices.contains(0) ? salaries[0].replacingOccurrences(of: "%", with: "") : "0"
        let femalePercentage = salaries.indices.contains(1) ? salaries[1].replacingOccurrences(of: "%", with: "") : "0"
        
        let maleCount = totalCount * (Int(malePercentage) ?? 0) / 100
        let femaleCount = totalCount * (Int(femalePercentage) ?? 0) / 100
        
        return [
            System(version: "man", count: maleCount, colors: "blue"),
            System(version: "woman", count: femaleCount, colors: "pink"),
        ]
    }
}
#Preview {
    CompanyCharts(data: System.dummyData(salaries: ["50%", "50%"]), salaries: ["100명", "50%", "50%"])
}

