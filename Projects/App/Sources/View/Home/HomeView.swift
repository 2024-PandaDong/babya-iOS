//
//  HomeView.swift
//  babya
//
//  Created by dgsw8th32 on 5/19/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var policyVM = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    @StateObject var companyVM : CompanyViewModel = .init(companyService: RemoteCompanyService())
    
    var body: some View {
        ZStack {
            ScrollView() {
                
                CustomPicker()
                
                Divider()
                    .padding(.top, -16)
                
                HStack {
                    Text("인기 있는 회사")
                        .font(.system(size: 16, weight: .black))
                    
                    Spacer()
                    
                    NavigationLink(destination: CompanySearchView()) {
                        Text("더보기")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 20)
                
                ForEach(companyVM.companyList, id: \.companyId) { company in
                    NavigationLink {
                        CompanyDetailView(companyId: company.companyId)
                            .navigationBarBackButtonHidden()
                    } label: {
                        CompanyCell(title: company.companyName, location: company.address, image: (company.logoImg.first ?? "dummy") ?? "dummy")
                            .padding(.horizontal)
                    }
                    .padding(.vertical, 5)
                }
                
                Divider()
                
                HStack {
                    Text("정책")
                        .font(.system(size: 16, weight: .black))
                    
                    Spacer()
                    
                    NavigationLink(destination: PolicyView()) {
                        Text("더보기")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                if !policyVM.model.isEmpty {
                    ForEach(0..<3, id: \.self) { index in
                        NavigationLink(
                            destination: PolicyDetailView(index: policyVM.model[index].policyId)
                        ) {
                            PolicyCell(title: policyVM.model[index].title, location: "", editDate: policyVM.model[index].editDate, imgUrl: "")
                                .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 100)
            }
            CustomTabBar()
        }
        .navigationBarBackButtonHidden()
        .task {
            await companyVM.getCompany(pageRequest: PageRequest(page: 1, size: 3))
        }
        .ignoresSafeArea()
        .onAppear {
            profileVM.getMyProfile()
            policyVM.getPolicyList(region: "104010")
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
