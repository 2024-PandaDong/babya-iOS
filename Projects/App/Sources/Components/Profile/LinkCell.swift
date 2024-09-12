//
//  LinkCell.swift
//  babya
//
//  Created by hyk on 8/29/24.
//

import SwiftUI

struct LinkCell: View {
    let title: String
    let link: String
    let isLast: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Link(destination: URL(string: link)!) {
                Rectangle()
                    .frame(height: 60)
                    .foregroundStyle(.white)
                    .overlay {
                        HStack {
                            Text(title)
                                .foregroundStyle(.black)
                                .font(.system(size: 16, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.LineNormal)
                        }
                        .padding(.horizontal, 25)
                    }
            }
            
            if !isLast {
                Divider()
            }
        }
    }
}

#Preview {
    ZStack {
        Color.PrimaryLight
        
        LinkCell(title: "프로필 수정", link: "www.youtube.com", isLast: false)
    }
}
