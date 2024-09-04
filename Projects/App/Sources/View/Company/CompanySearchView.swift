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
        NavigationStack{
            ZStack {
                Color.BackgroundStrong.ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Text("회사찾기")
                            .font(.system(size: 16, weight: .medium))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .padding(.bottom,5)
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 33)
                        
                        HStack(spacing:5){
                            Button {
                                showingSheet = true
                            } label: {
                                CompanyFilter(title: "지역")
                            }
                            .sheet(isPresented: $showingSheet) {
                                CompanySheet()
                            }
                            
                            CompanyFilter(title: "태그")
                            
                            Spacer()
                        }
                        .padding(.horizontal,7)
                    }
                    .padding(.bottom,5)
                    
                    ScrollView {
                        VStack(spacing: 3) {
                            ForEach(0..<3) { index in
                                NavigationLink {
                                    CompanyDetailView(title: "test", category: "tset", content: "tests")
                                } label: {
                                    CompanyRowCell(title: "삼성전자", image: "")
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}


#Preview {
    NavigationView {
        CompanySearchView()
    }
}
