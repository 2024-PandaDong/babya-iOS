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
        HStack(spacing: 10) {
            let datas = [
                ("전체", salaries.indices.contains(0) ? salaries[0] : "N/A"),
                ("남성", "\(calculatePercentage(salaries: salaries, index: 1))%"),
                ("여성", "\(calculatePercentage(salaries: salaries, index: 2))%")
            ]
            
            ForEach(datas, id: \.0) { item in
                VStack(spacing: 12) {
                    Text(item.0)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(item.1)
                        .font(.system(size: 14, weight: .semibold))
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
            .frame(width: 100, height: 100)
            .scaledToFit()
            .chartForegroundStyleScale([
                "pink": Color.pink70,
                "blue": Color.blue70
            ])
            .chartLegend(.hidden)
        }
    }

    func calculatePercentage(salaries: [String], index: Int) -> Int {
        let total = Int(salaries.indices.contains(0) ? salaries[0].replacingOccurrences(of: "명", with: "") : "0") ?? 0
        let count = Int(salaries.indices.contains(index) ? salaries[index].replacingOccurrences(of: "명", with: "") : "0") ?? 0
        return total > 0 ? (count * 100) / total : 0
    }
}
struct System {
    let version: String
    let count: Double
    let colors: String
    
    static func dummyData(maleCount: Int, femaleCount: Int) -> [System] {
        let totalCount = maleCount + femaleCount
        let malePercentage = totalCount > 0 ? (Double(maleCount) / Double(totalCount)) * 100 : 0
        let femalePercentage = totalCount > 0 ? (Double(femaleCount) / Double(totalCount)) * 100 : 0
        
        return [
            System(version: "남성", count: malePercentage, colors: "blue"),
            System(version: "여성", count: femalePercentage, colors: "pink")
        ]
    }
}

