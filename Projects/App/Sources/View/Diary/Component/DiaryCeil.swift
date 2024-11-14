//
//  DiaryCeil.swift
//  babya
//
//  Created by dgsw8th61 on 5/23/24.
//  Copyright © 2024 kr.hs.dgsw.dongbao. All rights reserved.
//

import Foundation
import SwiftUI

struct DiaryCeil : View {
    var ProfileImage : String
    var Title : String
    var UserName : String
    var Date : String
    var body: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 170)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.LineNormal,lineWidth:2)
                  )
                .overlay{
                    ZStack{
                        VStack(alignment: .leading){
                            if let imageUrl = URL(string: ProfileImage){
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .overlay(overlayView)
                                } placeholder: {
                                  ProgressView()
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                            }
                            
                            VStack(alignment: .leading){
                                Text(Title)
                                    .bold()
                                    .font(.system(size: 16))
                                    .foregroundColor(.LabelNormal)
                                    .padding(.bottom,1)
                                
                                Text(UserName)
                                    .font(.system(size: 14))
                                    .foregroundColor(.LabelAlternative)
                            }
                            .padding(.horizontal,6)
                            .padding(.vertical,10)
                            
                            Spacer()
                        }
                    }
                }
        }
    }
    
    private var overlayView: some View {
        HStack {
            VStack(alignment: .leading) {
                let formattedDate = formatDate(Date)
                Text(formattedDate)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(5)
                Spacer()
            }
            Spacer()
        }
    }
    
    func formatDate(_ date: String) -> String {
        let startIndex = date.index(date.startIndex, offsetBy: 5)
        let trimmedDate = String(date[startIndex...])
        
        let finalDate = trimmedDate.replacingOccurrences(of: "-", with: "/")
        return finalDate
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}
