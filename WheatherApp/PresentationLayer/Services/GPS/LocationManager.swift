import Foundation
import CoreLocation

class LocationManager: NSObject {
    // MARK: - Properties
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var locationDelegate: CurrentLocationManagerDelegate?
    var currentCoordinate: (Double, Double)?
        
    // MARK: - Helper methods
    public func reverseGeocoding(latitude: Double, longitude: Double, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: completionHandler)
    }
    
    public func startSearchingLocation() {
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
