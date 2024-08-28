//
//  CompaneyCharts.swift
//  babya
//
//  Created by dgsw8th61 on 8/28/24.
//

import SwiftUI
import Charts

struct CompanyCharts: View {
    var data: [iPhoneOperationSystem]
    var body: some View {
        
        Chart(data, id: \.version) { element in
            SectorMark(
                angle: .value("Usage", element.count),
                innerRadius: .ratio(0.618)
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

struct iPhoneOperationSystem {
    let version: String
    let count: Int
    let colors: String
    
    static func dummyData() -> [iPhoneOperationSystem] {
        return [
            iPhoneOperationSystem(version: "woman", count: 50, colors: "pink"),
            iPhoneOperationSystem(version: "man", count: 50, colors: "blue"),
        ]
    }
}

#Preview {
    CompanyCharts(data: iPhoneOperationSystem.dummyData())
}
