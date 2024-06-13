//
//  CompanyRowCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanyRowCell: View {
    let rank: String
    let image: String
    let title: String
    
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: 65)
            .foregroundStyle(.white)
            .overlay {
                HStack(spacing: 20) {
                    Text(rank)
                        .font(.system(size: 20, weight: .bold))
                    
                    AsyncImage(url: .init(string: ""))
                    
                    Text(title)
                        .font(.system(size: 20, weight: .bold))
                    
                    Spacer()
                    
                    NavigationLink(destination: CompanyDetailView()) {
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.black)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 5)
    }
}

#Preview {
    NavigationView {
        CompanyRowCell(rank: "", image: "", title: "")
    }
}
