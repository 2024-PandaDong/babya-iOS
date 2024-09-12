//
//  FavoritesView.swift
//  babya
//
//  Created by hyk on 6/6/24.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 245/255)
            
            ScrollView {
                VStack(spacing: 25) {
                    Spacer()
                        .frame(height: 80)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        Text("즐겨찾기 목록")
                            .font(.system(size: 20, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    FavoritesCell()
                    FavoritesCell()
                    FavoritesCell()
                    FavoritesCell()
                }
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("즐겨찾기")
                        .font(.system(size: 20, weight: .bold))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .ignoresSafeArea(.container)
    }
}

#Preview {
    NavigationView {
        FavoritesView()
    }
}
