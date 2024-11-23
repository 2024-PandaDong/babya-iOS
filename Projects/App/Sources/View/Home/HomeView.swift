import SwiftUI
import FlowKit
import CoreLocation

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var policyVM = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    @StateObject var companyVM: CompanyViewModel = .init(companyService: RemoteCompanyService())
    @StateObject var locationManager = LocationManager.shared
    @Flow var flow
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                CustomPicker()
                    .padding(.top, -20)
                
                Divider()
                    .padding(.top, -8)
                
                HomeMap(userName: profileVM.model.data.nickname)
                
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
        .navigationBarBackButtonHidden()
        .toolbarBackground(.hidden)
        .task {
            await companyVM.getCompany(pageRequest: PageRequest(page: 1, size: 3))
        }
        .onAppear {
            policyVM.model = []
            profileVM.getMyProfile()
            profileVM.getMyRegion()
            
            // 위치 권한 요청
            locationManager.requestAuthorization()
        }
        .onChange(of: locationManager.authorizationStatus) { status in
            // 위치 권한 상태가 변경되면 위치를 받아옴
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                locationManager.manager.startUpdatingLocation()
            }
        }
        .onChange(of: locationManager.currentLocation) { location in
            // 위치가 변경되면 처리하는 로직 (필요시 추가)
        }
        .padding(.top, -40)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
