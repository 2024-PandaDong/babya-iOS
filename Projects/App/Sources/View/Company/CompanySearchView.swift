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
    @State var showLocationView: Bool = false
    @StateObject var vm : CompanyViewModel = .init(companyService: RemoteCompanyService())
    @StateObject var viewModel = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    
    var body: some View {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(alignment: .leading ,spacing: 0) {
                    VStack{
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

                        HStack{
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
                            Spacer()
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 5)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.gray0)
                    
                    ScrollView {
                        VStack(spacing: 3) {
                            ForEach(vm.companyList, id: \.companyId) { company in
                                NavigationLink {
                                    CompanyDetailView(companyId: company.companyId)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    CompanyRowCell(title: company.companyName, images: (company.logoImg.first ?? "dummy") ?? "dummy", address: company.address)
                                }
                            }
                        }
                    }
                }
                Spacer()
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
        .task {
            await vm.getCompany(pageRequest: PageRequest(page: 1, size: 10))
        }
        .onAppear {
            profileVM.getMyProfile()
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showLocationView) {
            LocationView()
                .environmentObject(viewModel)
        }
    }
}


#Preview {
    CompanySearchView()
}
