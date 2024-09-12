//
//  CompanySearchView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanySearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Text("님의 지역")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("편집하기")
                                .foregroundStyle(Color.LabelAlternative)
                                .font(.system(size: 11, weight: .medium))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    Rectangle()
                        .frame(height: 5)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.gray0)
                    
                    ScrollView {
                        VStack(spacing: 3) {
                            ForEach(0..<3) { index in
                                NavigationLink {
                                    CompanyDetailView(title: "test", category: "tset", content: "test")
                                } label: {
                                    CompanyRowCell(title: "삼성전자", image: "")
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                VStack(alignment: .leading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .foregroundStyle(.black)
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundColor(.black)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    CompanySearchView()
}
