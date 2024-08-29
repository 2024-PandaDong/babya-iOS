//
//  PolicyView.swift
//  babya
//
//  Created by hyk on 8/28/24.
//

import SwiftUI

struct PolicyView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showLocationView: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 98)
            
            Divider()
            
            ScrollView(.horizontal) {
                HStack {
                    Button {
                        
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.clear)
                            .frame(width: 45, height: 25)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10).stroke(Color.PrimaryLight, lineWidth: 2)
                                
                                Text("전체")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.PrimaryLight)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    Button {
                        self.showLocationView = true
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.clear)
                            .frame(width: 60, height: 25)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10).stroke(Color.PrimaryLight, lineWidth: 2)
                                
                                HStack {
                                    Text("지역")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(Color.PrimaryLight)
                                    
                                    Image(systemName: "righttriangle.fill")
                                        .rotationEffect(.degrees(45))
                                        .font(.system(size: 7))
                                        .foregroundStyle(Color.PrimaryLight)
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .frame(height: 40)
            .padding(.horizontal)
            
            Divider()
            
            ScrollView {
                ForEach(0..<10, id: \.self) { index in
                    PolicyCell(title: "이승혁이승혁", location: "존잘", locationDetail: "알파메일", startDt: "2007-12-02", endDt: "2024-08-28", liked: 77, imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg")
                }
            }
        }
        .ignoresSafeArea()
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
            
            ToolbarItem(placement: .principal) {
                Text("정책")
                    .font(.system(size: 16, weight: .medium))
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showLocationView) {
            LocationView()
        }
    }
}

#Preview {
    NavigationView {
        PolicyView()
    }
}
