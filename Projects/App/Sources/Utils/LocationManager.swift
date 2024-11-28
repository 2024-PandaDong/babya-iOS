import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var manager: CLLocationManager
    @Published var currentLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus
    
    static let shared = LocationManager()
    
    override init() {
        self.manager = CLLocationManager()
        self.authorizationStatus = manager.authorizationStatus
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func requestAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.manager.requestWhenInUseAuthorization()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.currentLocation = newLocation
        print("New Location: \(newLocation)")
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
}
