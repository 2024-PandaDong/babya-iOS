//
//  CompanyRowCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanyRowCell: View {
    let title: String
    let images: String
    let address: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 86)
                .foregroundColor(.white)
            
            HStack(alignment: .center){
                
                VStack(alignment:.leading,spacing: 6){
                    Text("\(title)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.black)
                    
                    HStack(spacing: 2){
                        Text(address)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.LabelNeutral)
                    }
                }
                .padding(.horizontal,5)
                
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.LineNormal)
                        if let imageUrl = URL(string: images){
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Image("dummy")
                                    .resizable()
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(8, corners: .allCorners)
                        }
                        
//                        if let imageUrl = URL(string: ProfileImage){
//                            AsyncImage(url: imageUrl) { image in
//                                image
//                                    .resizable()
//                                    .overlay(overlayView)
//                            } placeholder: {
//                                Image("baseDiaryImage")
//                                    .resizable()
//                                    .scaledToFill()
//                                    .overlay(overlayView)
//                            }
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 100)
//                            .cornerRadius(10, corners: [.topLeft, .topRight])
//                        }
                    }
            }
            .padding(.horizontal,29)
        }
    }
}
