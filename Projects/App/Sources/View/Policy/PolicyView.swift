//
//  PolicyView.swift
//  babya
//
//  Created by hyk on 8/28/24.
//

import SwiftUI
import FlowKit

struct PolicyView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    @State var showLocationView: Bool = false
    @State var keyword: String = ""
    @Flow var flow
//    @State var selectedTab = "임신전"
//    
//    let choices = ["임신전", "임신중", "출산후"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
//            HStack {
//                ForEach(choices, id: \.self) { item in
//                    Button {
//                        withAnimation {
//                            self.selectedTab = item
//                        }
//                    } label: {
//                        Text(item)
//                            .fontWeight(selectedTab == item ? .bold : .medium)
//                    }
//                }
//            }
//            .padding(.horizontal)
//            .padding(.vertical, 10)
//            
//            RoundedRectangle(cornerRadius: 15)
//                .frame(width: 45, height: 1.5)
//                .foregroundStyle(Color.PrimaryLight)
//                .offset(x: selectedTab == "임신전" ? 16 : selectedTab == "임신중" ? 69 : 121)
            
            HStack {
                Text("\(profileVM.model.data.nickname)님의 지역")
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
            
            if let state = viewModel.selectedState, !viewModel.selectedDistrict.isEmpty {
                HStack {
                    Capsule()
                        .frame(width: viewModel.calculateWidth(for: state.name), height: 25)
                        .foregroundStyle(.clear)
                        .overlay {
                            Capsule().stroke(Color.PrimaryLight)
                            
                            Text(state.name)
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
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 8)
                .foregroundStyle(Color.ComponentFillAlternative)
            
            ScrollView {
                ForEach(0..<viewModel.model.count, id: \.self) { index in
                    Button{
                        flow.push(PolicyDetailView(index: viewModel.model[index].policyId),animated: false)
                    } label: {
                        PolicyCell(
                            title: viewModel.model[index].title,
                            location: "\(((viewModel.selectedState?.name) != nil) ? viewModel.selectedState!.name : "") \(viewModel.selectedDistrict)",
                            editDate: viewModel.model[index].editDate ?? "" , imgUrl: "", isInHome: false)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.profileVM.getMyRegion()
                    flow.pop()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                        .fontWeight(.medium)
                }
            }
            
            ToolbarItem(placement: .principal) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.ComponentFillStrong)
                    .frame(width: 266, height: 35)
                    .overlay {
                        TextField(text: $keyword, prompt: Text("원하는 정책을 입력해주세요.")) {
                            
                        }
                        .padding(.horizontal, 10)
                        .font(.system(size: 13))
                        .onSubmit() {
                            viewModel.getPolicyList(region: viewModel.regionCode, keyword: keyword)
                        }
                    }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.getPolicyList(region: viewModel.regionCode, keyword: keyword)
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
        .onAppear {
            viewModel.model = []
            viewModel.getPolicyList(region: viewModel.regionCode, keyword: "")
        }
    }
}

#Preview {
    NavigationView {
        PolicyView()
    }
}
