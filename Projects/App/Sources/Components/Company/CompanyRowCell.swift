//
//  CompanyRowCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI
import Kingfisher

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
                            .multilineTextAlignment(.leading)
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
                            KFImage(imageUrl)
                                .placeholder {
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 120, height: 120)))
                                .cacheMemoryOnly()
                                .fade(duration: 0.25)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
            }
            .padding(.horizontal,29)
        }
    }
}
