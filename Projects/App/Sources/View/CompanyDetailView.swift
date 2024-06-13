//
//  CompanyDetailView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 280, height: 160)
            
            HStack {
                Text("삼성전자")
                    .font(.system(size: 24, weight: .bold))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("회사 홈페이지 바로가기")
                        .foregroundStyle(.gray)
                        .font(.system(size: 12))
                }
                .padding(.vertical, 20)
            }
            .padding(.horizontal, 30)
            
            Spacer()
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
                Text("회사찾기")
                    .font(.system(size: 20, weight: .bold))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundStyle(.black)
                        .font(.system(size: 15))
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        CompanyDetailView()
    }
}
