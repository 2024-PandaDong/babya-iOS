//
//  SalaryInfoCell.swift
//  babya
//
//  Created by dgsw8th61 on 8/29/24.
//

import SwiftUI

struct SalaryInfoCell: View {
    var salaries: [String]

    var body: some View {
        HStack(spacing: 36) {
            let data = [
                ("최저", salaries.indices.contains(0) ? salaries[0] : "N/A"),
                ("평균", salaries.indices.contains(1) ? salaries[1] : "N/A"),
                ("최대", salaries.indices.contains(2) ? salaries[2] : "N/A"),
            ]
            
            ForEach(data, id: \.0) { item in
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.0)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.Opacity35)
                    
                    Text(item.1)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color.black)
                }
            }
        }
    }
}
