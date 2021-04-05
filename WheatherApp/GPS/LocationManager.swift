import Foundation
import CoreLocation

protocol CurrentLocationManagerDelegate {
    func showLocationDeniedAlert()
    func updateCurrentCoordinate(with coordinate: (Double, Double))
}

class LocationManager: NSObject {
    // MARK: - Properties
    static let shared = LocationManager()
    
    var locationDelegate: CurrentLocationManagerDelegate?
    var locationManager = CLLocationManager()
    var currentCoordinate: (Double, Double)?
    
    // MARK: - init methods
    private override init() {
        super.init()
        defineAccess()
    }
    
    // MARK: - Private methods
    private func defineAccess() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
            locationDelegate?.showLocationDeniedAlert()
        }
       
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
}

// MARK: - Extensions
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        
        print("LATITUDE: \(currentLocation.coordinate.latitude)")
        print("LONGITUDE: \(currentLocation.coordinate.longitude)")
        
        locationDelegate?.updateCurrentCoordinate(with: (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude))
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR: \(error.localizedDescription)")
    }
}
