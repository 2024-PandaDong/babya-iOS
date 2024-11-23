import SwiftUI
import MapKit
import CoreLocation

struct HospitalView: View {
    @StateObject var viewModel = HospitalViewModel.shared
    @StateObject var locationManager = LocationManager.shared
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 서울 시청
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        VStack {
            if locationManager.authorizationStatus == .denied {
                // 사용자가 위치 접근 권한을 거부한 경우
                VStack {
                    Text("Location Access Denied")
                        .font(.headline)
                    Text("Please enable location access in settings.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            } else if locationManager.currentLocation == nil {
                // 위치 정보가 아직 없는 경우
                Text("Requesting location access...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .onAppear {
                        if let location = locationManager.currentLocation {
                            region.center = location.coordinate
                        }
                    }
                    .onChange(of: locationManager.currentLocation) { location in
                        if let location = location {
                            region.center = location.coordinate
                        }
                    }
            }
        }
        .onAppear {
            locationManager.requestAuthorization()
        }
    }
}



#Preview {
    HospitalView()
}
