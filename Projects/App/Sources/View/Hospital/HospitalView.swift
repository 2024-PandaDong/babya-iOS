import SwiftUI
import MapKit
import CoreLocation
import FlowKit

struct HospitalView: View {
    @StateObject var viewModel = HospitalViewModel.shared
    @StateObject var locationManager = LocationManager.shared
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.51187700748316, longitude: 127.05982257447918),
        span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
    )
    @Flow var flow
    @State var currentTab: String = "산부인과"
    @State private var showSheet = false
    @State private var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack {
                if locationManager.authorizationStatus == .denied {
                    VStack {
                        Text("위치 접근이 거부되었습니다.")
                            .font(.headline)
                        Text("설정에서 위치 접근을 허용해 주세요.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                } else {
                    Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: viewModel.places) { place in
                        MapAnnotation(coordinate: place.location) {
                            VStack {
                                Circle()
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(Color(red: 94/255, green: 78/255, blue: 210/255))
                                    .overlay {
                                        Circle().stroke(.white, lineWidth: 2)
                                        
                                        Image("hospitalWhite")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 12)
                                    }
                                
                                Text(place.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.LabelAssistive)
                                    .shadow(color: .white, radius: 0, x: 0.7, y: 0.7)
                                    .shadow(color: .white, radius: 0, x: -0.7, y: 0.7)
                                    .shadow(color: .white, radius: 0, x: 0.7, y: -0.7)
                                    .shadow(color: .white, radius: 0, x: -0.7, y: -0.7)
                            }
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        if let location = locationManager.currentLocation {
                            region.center = location.coordinate
                        }
                        viewModel.getHospital(latitude: region.center.latitude, longitude: region.center.longitude, keyword: "산부인과")
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                locationManager.requestAuthorization()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        flow.pop()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
            }
            
            VStack {
                HStack {
                    Button {
                        withAnimation {
                            self.currentTab = "산부인과"
                            viewModel.getHospital(latitude: region.center.latitude, longitude: region.center.longitude, keyword: "산부인과")
                            self.showSheet = true
                        }
                    } label: {
                        Capsule()
                            .frame(width: 85, height: 35)
                            .foregroundStyle(.white)
                            .shadow(radius: 2, y: 1)
                            .overlay {
                                Capsule().stroke(self.currentTab == "산부인과" ? Color.PrimaryNormal : .white, lineWidth: 1.5)
                                
                                HStack(spacing: 5) {
                                    Image("hospital")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                    
                                    Text("산부인과")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.leading, 20)
                    }
                    .frame(height: 37)
                    
                    Button {
                        withAnimation {
                            self.currentTab = "응급실"
                            viewModel.getHospital(latitude: region.center.latitude, longitude: region.center.longitude, keyword: "응급실 병원")
                            self.showSheet = true
                        }
                    } label: {
                        Capsule()
                            .frame(width: 85, height: 35)
                            .foregroundStyle(.white)
                            .shadow(radius: 2, y: 1)
                            .overlay {
                                Capsule().stroke(self.currentTab == "응급실" ? Color.PrimaryNormal : .white, lineWidth: 1.5)
                                
                                HStack(spacing: 5) {
                                    Image("hospital")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                    
                                    Text("응급실")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.black)
                                }
                            }
                    }
                    .frame(height: 37)
                    
                    Spacer()
                }
                .frame(height: 37)
                
                Spacer()
                
                HStack {
                    Button {
                        withAnimation {
                            if let location = locationManager.currentLocation {
                                region.center = location.coordinate
                            }
                        }
                    } label: {
                        Circle()
                            .frame(width: 45, height: 45)
                            .foregroundStyle(.white)
                            .overlay {
                                Image(systemName: "scope")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                                    .foregroundStyle(.black)
                            }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                Rectangle()
                    .frame(width: .infinity, height: 30)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        Capsule()
                            .frame(width: 60, height: 7)
                            .foregroundStyle(Color.ComponentMaterialDimmer)
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if value.translation.height < 0 {
                                    dragOffset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                if value.translation.height < -100 {
                                    showSheet = true
                                }
                                dragOffset = 0
                            }
                    )
                    .onTapGesture {
                        self.showSheet = true
                    }
            }
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 0) {
                Capsule()
                    .frame(width: 60, height: 7)
                    .foregroundStyle(Color.ComponentMaterialDimmer)
                    .padding(.vertical)
                
                ScrollView {
                    ForEach(0..<(viewModel.model.documents?.count ?? 0), id: \.self) { index in
                        HospitalCell(
                            name: viewModel.model.documents?[index].place_name ?? "알 수 없음",
                            category: self.currentTab,
                            tel: viewModel.model.documents?[index].phone ?? "알 수 없음",
                            distance: viewModel.model.documents?[index].distance ?? "알 수 없음",
                            address: viewModel.model.documents?[index].road_address_name ?? "알 수 없음",
                            id: viewModel.model.documents?[index].id ?? "알 수 없음"
                        )
                    }
                }
                
                Spacer()
            }
            .presentationDragIndicator(.hidden)
            .presentationDetents([.medium, .large])
            .presentationBackgroundInteraction(.enabled)
        }
    }
}

#Preview {
    HospitalView()
}
