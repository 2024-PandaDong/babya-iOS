import SwiftUI
import MapKit
import CoreLocation
import FlowKit

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel.shared
    @StateObject var policyVM = PolicyViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    @StateObject var companyVM: CompanyViewModel = .init(companyService: RemoteCompanyService())
    @StateObject var locationManager = LocationManager.shared
    @Flow var flow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 서울 시청
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                CustomPicker()

                Divider()
                    .padding(.top, -8)
                
                HospitalSection(region: $region, homeVM: homeVM)
                
                VStack {
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
                            CompanyCell(
                                title: company.companyName,
                                location: company.address,
                                image: (company.logoImg.first ?? "dummy") ?? "dummy"
                            )
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 5)
                    }
                    
                    Divider()
                }
                
                VStack(alignment: .leading) {
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
                                    location: "\(policyVM.selectedState?.name ?? "") \(policyVM.selectedDistrict)",
                                    editDate: policyVM.model[index].editDate ?? "",
                                    imgUrl: "",
                                    isInHome: true
                                )
                                .padding(.horizontal)
                            }
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
            
            locationManager.requestAuthorization()
            if let location = locationManager.currentLocation {
                updateRegionAndHospital(location: location)
            }
        }
        .onChange(of: locationManager.currentLocation) { newLocation in
            if let newLocation = newLocation {
                updateRegionAndHospital(location: newLocation)
            }
        }
        .onChange(of: locationManager.authorizationStatus) { status in
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                locationManager.manager.startUpdatingLocation()
            }
        }
        .padding(.top, -40)
    }
    
    private func updateRegionAndHospital(location: CLLocation) {
        region.center = location.coordinate
        homeVM.getHospital(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}

struct HospitalSection: View {
    @Binding var region: MKCoordinateRegion
    @StateObject var homeVM = HomeViewModel.shared
    @StateObject var profileVM = ProfileViewModel.shared
    @Flow var flow
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(profileVM.model.data.nickname)님, 가장 가까운 산부인과는 여기에 있어요")
                .font(.system(size: 16, weight: .bold))
            
            Button {
                flow.push(HospitalView(), animated: false)
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity, minHeight: 140, maxHeight: 140)
                    .overlay {
                        Map(coordinateRegion: $region, showsUserLocation: true)
                            .cornerRadius(10)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Text(homeVM.hospitalResonse.documents?.first?.place_name ?? "불러오는 중...")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 8)
                                    .frame(height: 35)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundStyle(.white)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.gray, lineWidth: 1)
                                            }
                                    )
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                        }
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}


#Preview {
    NavigationView {
        HomeView()
    }
}
