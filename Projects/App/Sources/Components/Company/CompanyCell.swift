//
//  CompanyCell.swift
//  babya
//
//  Created by dgsw8th32 on 5/23/24.
//

import SwiftUI

struct CompanyCell: View {
    let title: String
    let image: String
    
    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 110, height: 110)
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(.gray)
                    
                    if image == nil {
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
            
            Text("\(title)")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    CompanyCell(title: "삼성전자", image: "")
}
