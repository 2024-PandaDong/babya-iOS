//
//  PolicyDetailView.swift
//  babya
//
//  Created by hyk on 8/29/24.
//

import SwiftUI

struct PolicyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let imgUrl: String
    let title: String
    let startDt: String
    let endDt: String
    let org: String
    let location: String
    let content: String
    
    var body: some View {
        ZStack {
            Color.BackgroundStrong
            
            ScrollView {
                if !imgUrl.isEmpty {
                    AsyncImage(url: URL(string: imgUrl)) { image in
                        image
                            .image?
                            .resizable()
                            .frame(width: 350, height: 200)
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.top, 35)
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 140)
                    .foregroundStyle(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(Color.LineNormal, lineWidth: 2)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(title)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("\(startDt) ~ \(endDt)")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(Color.LabelDisable)
                                
                                HStack {
                                    Text("시행기관:")
                                        .fontWeight(.semibold)
                                    Text(org)
                                }
                                .font(.system(size: 14))
                                .padding(.vertical, 5)
                                
                                HStack {
                                    Text("범주:")
                                        .fontWeight(.semibold)
                                    Text(location)
                                }
                                .font(.system(size: 14))
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                
                Text(content)
                    .padding(.horizontal, 20)
                    .font(.system(size: 14, weight: .regular))
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "light.beacon.max")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
            }
            
            VStack {
                Spacer()
                
                Link(destination: URL(string: "https://www.apple.com")!) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 330, height: 50)
                        .foregroundStyle(!imgUrl.isEmpty ? Color.PrimaryLight : .ComponentMaterialDimmer)
                        .overlay {
                            Text("내용이 더 궁금하다면?")
                                .foregroundStyle(.white)
                                .font(.system(size: 14, weight: .bold))
                        }
                }
                .padding(.vertical)
                .disabled(imgUrl.isEmpty)
            }
        }
    }
}

#Preview {
    NavigationView {
        PolicyDetailView(imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg", title: "범어사 1번", startDt: "2007.12.02", endDt: "2024.08.29", org: "금정중학교", location: "전국", content: "이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁이승혁")
    }
}
