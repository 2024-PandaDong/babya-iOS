//
//  PolicyCell.swift
//  babya
//
//  Created by hyk on 8/28/24.
//

import SwiftUI

struct PolicyCell: View {
    let title: String
    let location: String
    let locationDetail: String
    let startDt: String
    let endDt: String
    let imgUrl: String
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: 130)
                .foregroundStyle(.white)
                .overlay {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(title)
                                .font(.system(size: 16, weight: .semibold))
                            
                            HStack {
                                Text(location)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text(locationDetail)
                                    .font(.system(size: 14, weight: .medium))
                            }
                            
                            HStack {
                                Text("\(startDt) ~ \(endDt)")
                                    .font(.system(size: 14, weight: .medium))
                            }
                        }
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: imgUrl)) { image in
                            image
                                .image?
                                .resizable()
                                .frame(width: 80, height: 80)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(.horizontal, 15)
                }
            
            Divider()
        }
        .tint(.black)
    }
}

#Preview {
    NavigationView {
        ZStack {
            Color.black
            
            PolicyCell(title: "이승혁이승혁", location: "존잘", locationDetail: "알파메일", startDt: "2007-12-02", endDt: "2024-08-28", imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg")
        }
    }
        
}
