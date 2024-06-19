//
//  CompanySearchView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanySearchView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    HStack {
                        Text("회사추천")
                            .font(.system(size: 20, weight: .bold))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    CompanyRowCell(rank: "1위", image: "", title: "삼성전자")
                    
                    Spacer()
                        .frame(height: 100)
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color(red: 245/255, green: 245/255, blue: 245/255))
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
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        CompanySearchView()
    }
}
