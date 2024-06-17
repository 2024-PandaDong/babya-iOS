//
//  CommentCell.swift
//  babya
//
//  Created by hyk on 6/7/24.
//

import SwiftUI

struct CommentCell: View {
    @Binding var name: String
    @Binding var day: String
    @Binding var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Circle()
                    .frame(width: 25, height: 25)
                    .offset(x: 0, y: 10)
                
                Text(name)
                    .font(.system(size: 14, weight: .bold))
                
                Text(day)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.gray)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Text(content)
                .font(.system(size: 12))
                .padding(.horizontal, 55)
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding(.vertical, 10)
        }
    }
}

#Preview {
    CommentCell(name: .constant(""), day: .constant(""), content: .constant(""))
}
