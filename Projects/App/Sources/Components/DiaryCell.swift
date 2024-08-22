//
//  DiaryCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct DiaryCell: View {
    let writtenDt: String
    let title: String
    
    var body: some View {
        VStack {
            HStack {
                if writtenDt.count >= 10 {
                    let start = writtenDt.index(writtenDt.startIndex, offsetBy: 5)
                    let end = writtenDt.index(writtenDt.startIndex, offsetBy: 10)
                    let monthDay = writtenDt.substring(with: start..<end)
                                    
                    Capsule()
                        .frame(width: 60, height: 20)
                        .foregroundColor(Color(red: 255/255, green: 227/255, blue: 139/255))
                        .overlay {
                            Text(monthDay)
                                .font(.system(size: 12))
                                .foregroundColor(Color(red: 255/255, green: 138/255, blue: 0/255))
                        }
                }
                
                Circle()
                    .frame(width: 15, height: 15)
                
                Spacer()
            }
            
            HStack {
                Text(title)
                
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
    DiaryCell(writtenDt: "", title: "")
}
