//
//  PostCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct PostCell: View {
    let createdAt: String
    let title: String
    
    var body: some View {
        VStack {
            HStack {
                if createdAt.count >= 10 {
                    let start = createdAt.index(createdAt.startIndex, offsetBy: 5)
                    let end = createdAt.index(createdAt.startIndex, offsetBy: 10)
                    let monthDay = createdAt.substring(with: start..<end)
                                    
                    Capsule()
                        .frame(width: 60, height: 20)
                        .foregroundColor(Color(red: 255/255, green: 227/255, blue: 139/255))
                        .overlay {
                            Text(monthDay)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(red: 255/255, green: 138/255, blue: 0/255))
                        }
                }
                
                Spacer()
            }
            
            HStack {
                Text(title)
                
                Spacer()
                
                NavigationLink(destination: Text("게시물")) {
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.black)
                }
            }
            
            Rectangle()
                .frame(width: 320, height: 1)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 5)
    }
}

#Preview {
    PostCell(createdAt: "", title: "")
}
