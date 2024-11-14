import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var policyVM = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    @StateObject var companyVM: CompanyViewModel = .init(companyService: RemoteCompanyService())
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    CustomPicker()
                        .padding(.top,-20)
                    
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
                                PolicyCell(
                                    title: policyVM.model[index].title,
                                    location: "\(((policyVM.selectedState?.name) != nil) ? policyVM.selectedState!.name : "") \(policyVM.selectedDistrict)",
                                    editDate: policyVM.model[index].editDate ?? "", imgUrl: "", isInHome: true)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 100)
                }
                .background(Color.clear)
                
                VStack {
                    Spacer()
                    
                    CustomTabBar()
                        .background(Color.clear)
                        .padding(.bottom, -30)
                }
            }
            .toolbar(.hidden)
            .task {
                await companyVM.getCompany(pageRequest: PageRequest(page: 1, size: 3))
            }
            .onAppear {
                policyVM.model = []
                profileVM.getMyProfile()
                profileVM.getMyRegion()
            }
            .padding(.top, -40)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
