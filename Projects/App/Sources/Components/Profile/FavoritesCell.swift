//
//  FavoritesCell.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import SwiftUI

struct FavoritesCell: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 350, height: 60)
            .foregroundStyle(.white)
            .overlay {
                HStack(spacing: 15) {
                    Text("규민이 아빠")
                        .font(.system(size: 24, weight: .bold))
                    
                    Circle()
                        .frame(width: 30, height: 30)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                            .font(.system(size: 20))
                    }
                }
                .padding(.horizontal, 20)
            }
    }
}

#Preview {
    ZStack {
        Color.gray
        
        FavoritesCell()
    }
}
