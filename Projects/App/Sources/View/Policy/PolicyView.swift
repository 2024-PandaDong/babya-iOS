//
//  PolicyView.swift
//  babya
//
//  Created by hyk on 8/28/24.
//

import SwiftUI

struct PolicyView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = PolicyViewModel()
    @State var showLocationView: Bool = false
    @State var selectedTab = "임신전"
    
    let choices = ["임신전", "임신중", "출산후"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                ForEach(choices, id: \.self) { item in
                    Button {
                        withAnimation {
                            self.selectedTab = item
                        }
                    } label: {
                        Text(item)
                            .fontWeight(selectedTab == item ? .bold : .medium)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 45, height: 1.5)
                .foregroundStyle(Color.PrimaryLight)
                .offset(x: selectedTab == "임신전" ? 16 : selectedTab == "임신중" ? 69 : 121)
            
            Divider()
            
            HStack {
                Text("박규민님의 지역")
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Button {
                    self.showLocationView = true
                } label: {
                    Text("편집하기")
                        .foregroundStyle(Color.LabelAlternative)
                        .font(.system(size: 11, weight: .medium))
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            if !viewModel.selectedState.isEmpty && !viewModel.selectedDistrict.isEmpty {
                HStack {
                    Capsule()
                        .frame(width: viewModel.calculateWidth(for: viewModel.selectedState), height: 25)
                        .foregroundStyle(.clear)
                        .overlay {
                            Capsule().stroke(Color.PrimaryLight)
                            
                            Text(viewModel.selectedState)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.PrimaryLight)
                        }
                    
                    Capsule()
                        .frame(width: viewModel.calculateWidth(for: viewModel.selectedDistrict), height: 25)
                        .foregroundStyle(.clear)
                        .overlay {
                            Capsule().stroke(Color.PrimaryLight)
                            
                            Text(viewModel.selectedDistrict)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.PrimaryLight)
                        }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            Divider()
            
            ScrollView {
                ForEach(0..<10, id: \.self) { index in
                    NavigationLink(destination: Text("\(index)")) {
                        PolicyCell(title: "이승혁이승혁", location: "존잘", locationDetail: "알파메일", startDt: "2007-12-02", endDt: "2024-08-28", imgUrl: "https://cdn.hankyung.com/photo/201810/01.18067557.1.jpg")
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                VStack(alignment: .leading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showLocationView) {
            LocationView()
                .environmentObject(viewModel)
        }
        .tint(.black)
    }
}

#Preview {
    NavigationView {
        PolicyView()
    }
}
