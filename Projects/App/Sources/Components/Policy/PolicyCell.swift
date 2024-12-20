//
//  PolicyCell.swift
//  babya
//
//  Created by hyk on 8/28/24.
//

import SwiftUI

struct PolicyCell: View {
    let title: String
    let location: String
    let editDate: String
    let imgUrl: String
    let isInHome: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 130)
                .foregroundStyle(.white)
                .overlay {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(title)
                                .font(.system(size: 16, weight: .semibold))
                            
                            Text(location)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.LabelNeutral)
                            
                            HStack {
                                Text("최종수정일: \(editDate)")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.LabelNeutral)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                }
            
            if !isInHome {
                Divider()
            }
        }
        .tint(.black)
    }
}

#Preview {
    NavigationView {
        ZStack {
            Color.black
            
            PolicyCell(title: "이승혁이승혁", location: "존잘", editDate: "2024-09-11", imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg", isInHome: false)
        }
    }
        
}
