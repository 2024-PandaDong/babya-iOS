//
//  DiaryCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct DiaryCell: View {
    var body: some View {
        VStack {
            HStack {
                Capsule()
                    .frame(width: 50, height: 15)
                    .foregroundStyle(Color(red: 255/255, green: 227/255, blue: 139/255))
                    .overlay {
                        Text("3/27")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(red: 255/255, green: 138/255, blue: 0/255))
                }
                
                Circle()
                    .frame(width: 15, height: 15)
                
                Spacer()
            }
            
            HStack {
                Text("동동이 심장소리 들어본 날!")
                
                Spacer()
                
                NavigationLink(destination: Text("산모일기")) {
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
    DiaryCell()
}
