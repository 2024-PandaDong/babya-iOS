//
//  CompanyRowCell.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanyRowCell: View {
    let title: String
    let image: String
    
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
                        Image("star")
                            .resizable()
                            .frame(width: 16,height: 14)
                        Text("4.5")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                        
                        Text("수원시")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.LabelNeutral)
                            .padding(.horizontal,5)
                        
                    }
                }
                Spacer()
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8).stroke(Color.LineNormal)
                        
                        if image != "dummy" {
                            AsyncImage(url: URL(string: image)) { image in
                                image.image?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            }
                        } else {
                            Image("\(image)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                    }
            }
            .padding(.horizontal,15)
        }
    }
}

#Preview {
    NavigationView {
        CompanyRowCell(title: "", image: "")
    }
}
