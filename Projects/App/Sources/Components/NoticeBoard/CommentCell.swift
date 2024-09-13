//
//  CommentCell.swift
//  babya
//
//  Created by hyk on 6/7/24.
//

import SwiftUI

struct CommentCell: View {
    let model: PostCommentResponse
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Circle()
                    .frame(width: 25, height: 25)
                    .overlay {
                        Image("baseProfile")
                            .resizable()
                            .scaledToFit()
                    }
                    .offset(x: 0, y: 10)
                
                Text(model.data[index].nickname)
                    .font(.system(size: 14, weight: .bold))
                
                Text(model.data[index].createdAt.prefix(10))
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.gray)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Text(model.data[index].content)
                .font(.system(size: 12))
                .padding(.horizontal, 55)
            
            Button {
                
            } label: {
                Text("답글달기")
                    .font(.system(size: 11))
                    .foregroundStyle(.gray)
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray)
                .padding(.vertical, 10)
        }
    }
}