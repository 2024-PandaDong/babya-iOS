//
//  NoticeBoardDetailView.swift
//  babya
//
//  Created by hyk on 6/4/24.
//

import SwiftUI

struct NoticeBoardDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            HStack(spacing: 10) {
                Circle()
                    .frame(width: 45, height: 45)
                
                VStack(spacing: 3) {
                    HStack {
                        Text("동동이맘")
                            .font(.system(size: 16, weight: .bold))
                        Button {
                            
                        } label: {
                            Image(systemName: "star")
                                .font(.system(size: 15))
                                .foregroundStyle(.black)
                        }
                        
                        Spacer()
                        
                        Text("30분 전")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                    }
                    
                    HStack {
                        Image(systemName: "eye.fill")
                            .foregroundStyle(.gray)
                        
                        Text("76")
                        
                        Image(systemName: "bubble")
                            .foregroundStyle(.gray)
                        
                        Text("12")
                        
                        Spacer()
                    }
                    .font(.system(size: 15))
                }
            }
            .padding(.horizontal, 20)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 370, height: 240)
            
            HStack {
                Text("오늘부터 4주차 동동이 엄마 입니다.\n임신한 후에 모임 가지면서 요가 같이 해봐요~")
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1)
                .foregroundStyle(.gray)
                .padding(.vertical, 15)
            
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                
                Text("소망이아빠")
                
                Spacer()
            }
            .padding(.horizontal, 10)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("임산부 취미 공유합니다!")
                    .font(.system(size: 20, weight: .bold))
            }
        }
    }
}

#Preview {
    NavigationView {
        NoticeBoardDetailView()
    }
}
