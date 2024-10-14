//
//  CompanyCell.swift
//  babya
//
//  Created by dgsw8th32 on 5/23/24.
//

import SwiftUI

struct CompanyCell: View {
    let title: String
    let location: String
    let image: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                
                Text(location)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.LabelAssistive)
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 60, height: 60)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 8).stroke(Color.LineNormal)
                    
                    if image != "dummy" {
                        AsyncImage(url: URL(string: image)) { image in
                            image.image?
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                    } else {
                        Image("\(image)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }
                }
        }
        .tint(.black)
        .padding(.vertical, 5)
        .padding(.horizontal, 15)
    }
}

#Preview {
    CompanyCell(title: "삼성전자", location: "서울특별시 강동구 상일로6길 26 (상일동)", image: "https://ekiya-s3.s3.ap-northeast-2.amazonaws.com/ekiya-s3/a7c42ce6-3c99-4286-87b3-00774f733b93%E1%84%83%E1%85%A1%E1%86%BC%E1%84%80%E1%85%B3%E1%86%AB%E1%84%86%E1%85%A1%E1%84%8F%E1%85%A6%E1%86%BA_logo.png")
}
