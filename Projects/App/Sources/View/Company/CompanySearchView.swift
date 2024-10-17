//
//  CompanySearchView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI

struct CompanySearchView: View {
    @GestureState private var dragOffset = CGSize.zero
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
                        Text("가족 친화적인 회사 리스트")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundStyle(.black)
                            .padding(.top,15)
                            .padding(.bottom,4)
                            .padding(.horizontal)
                    
                        Text("\(profileVM.model.data.nickname)님과 맞는 회사를 찾아보세요")
                            .font(.system(size: 11,weight: .semibold))
                            .foregroundStyle(Color.gray)
                            .padding(.horizontal)
                            .padding(.bottom,12)
                    
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
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
    }
}


#Preview {
    CompanySearchView()
}
