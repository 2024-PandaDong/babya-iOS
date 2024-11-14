//
//  CompanySearchView.swift
//  babya
//
//  Created by hyk on 6/3/24.
//

import SwiftUI
import FlowKit

struct CompanySearchView: View {
    @GestureState private var dragOffset = CGSize.zero
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSheet = false
    @State var showLocationView: Bool = false
    @StateObject var vm : CompanyViewModel = .init(companyService: RemoteCompanyService())
    @StateObject var viewModel = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    @State private var count: Int = 0
    @State var nowPage : Int = 1
    @Flow var flow
    
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
                            Button{
                                flow.push(CompanyDetailView(companyId: company.companyId),animated: false)
                            }label: {
                                CompanyRowCell(title: company.companyName, images: (company.logoImg.first ?? "dummy") ?? "dummy", address: company.address)
                                    .onAppear{
                                        count += 1
                                        print(count)
                                        if count % 10 == 9 {
                                            nowPage += 1
                                        }
                                    }
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
//                        self.presentationMode.wrappedValue.dismiss()
                        flow.pop()
                    } label: {
                        Image(systemName: "arrow.left")
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
        .onChange(of: nowPage, perform: { value in
            Task{
                await vm.getCompany(pageRequest: PageRequest(page: 1 , size: count + 10))
            }
        })
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
