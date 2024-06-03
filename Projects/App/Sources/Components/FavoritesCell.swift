//
//  FavoritesCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct FavoritesCell: View {
    var body: some View {
        HStack {
            Text("규민이 아빠")
                .font(.system(size: 12, weight: .bold))
            
            Circle()
                .frame(width: 18, height: 18)
        }
    }
}

#Preview {
    FavoritesCell()
}
