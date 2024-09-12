//
//  CompanyRowCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanyRowCell: View {
    let title: String
    let image: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 86)
                .foregroundColor(.white)
            
            HStack(alignment: .center){
                
                VStack(alignment:.leading,spacing: 6){
                    Text("\(title)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.black)
                    
                    HStack(spacing: 2){
                        Text("서울특별시 강동구 상일로6길 26 (상일동)")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.LabelNeutral)
                    }
                }
                .padding(.horizontal,5)
                
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.LineNormal)
                        
                        Image("\(image)")
                    }
            }
            .padding(.horizontal,15)
        }
    }
}

#Preview {
    NavigationView {
        CompanyRowCell(title: "d", image: "")
    }
}
