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
                    .foregroundStyle(.black)
                
                Text(location)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.LabelAlternative)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 60, height: 60)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(.gray)
                    
                    if image != nil {
                        AsyncImage(url: URL(string: image)) { image in
                            image
                                .image?
                                .resizable()
                                .scaledToFit()
                        }
                    } else {
                        Image("dummy")
                            .resizable()
                            .scaledToFit()
                    }
                }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CompanyCell(title: "삼성전자", location: "서울특별시 강동구 상일로6길 26 (상일동)", image: "")
}
