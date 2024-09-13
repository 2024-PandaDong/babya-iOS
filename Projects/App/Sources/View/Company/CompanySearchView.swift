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
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.white.ignoresSafeArea()
                VStack(spacing: 0) {
                    VStack{
                        HStack {
                            Text("이윤채님의 지역")
                                .font(.system(size: 16, weight: .semibold))
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("편집하기")
                                    .foregroundStyle(Color.LabelAlternative)
                                    .font(.system(size: 11, weight: .medium))
                            }
                        }
                        
                        HStack(spacing: 12){
                            CompanyFilter(isSelect: true, title: "대구광역시")
                            CompanyFilter(isSelect: true, title: "달성군")
                            Spacer()
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
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    CompanySearchView()
}
