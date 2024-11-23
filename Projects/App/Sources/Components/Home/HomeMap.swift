import SwiftUI
import MapKit
import CoreLocation
import FlowKit

struct HomeMap: View {
    let userName: String
    @StateObject private var locationManager = LocationManager.shared
    @State private var region: MKCoordinateRegion
    @Flow var flow
    
    init(userName: String) {
        self.userName = userName
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(userName)님, 가장 가까운 산부인과는 여기에 있어요")
                .font(.system(size: 16, weight: .bold))
            
            Button {
                flow.push(HospitalView(), animated: false)
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth: .infinity, minHeight: 140, maxHeight: 140)
                    .overlay {
                        Map(coordinateRegion: $region, showsUserLocation: true)
                            .cornerRadius(10)
                    }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .onAppear {
            locationManager.requestAuthorization()
        }
        .onChange(of: locationManager.currentLocation) { newLocation in
            if let newLocation = newLocation {
                region.center = newLocation.coordinate
            }
        }
    }
}

#Preview {
    HomeMap(userName: "이승혁")
}
