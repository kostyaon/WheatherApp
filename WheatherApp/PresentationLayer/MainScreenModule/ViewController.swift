import Foundation
import UIKit
import CoreLocation

class ViewController: UIViewController {
    // MARK: - Properties
    var currentCoordinate: CLLocationCoordinate2D?
    lazy var locationManager = CLLocationManager()
    
    
    // MARK: - Views methods
    override func loadView() {
        let mainScreen = MainScreenView()
        self.view = mainScreen
        self.view.backgroundColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Find current location
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
            showLocationDeniedAlert()
            return
        }
    
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        } else {
            print("Off")
        }
        
        
        if let coordinate = currentCoordinate {
            // Fetch data and update MainScreen
            WeatherAPIManager.fetch(type: WeatherResponse.self, router: WeatherRouter.fetchWeatherOneCall(coordinate.latitude, coordinate.longitude, "minutely,alerts", AppEnvironment.apiKey)) { result in
                switch result {
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                case .success(let response):
                    DispatchQueue.main.async {
                        (self.view as? MainScreenView)?.updateView(with: response)
                    }
                }
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Private methods
    private func showLocationDeniedAlert(){
        let alert = UIAlertController(title: "Location Services Disabled", message: "Enable location services for 'Map-Tag' in Settings", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extensions
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0]
        
        print(currentLocation.coordinate.latitude)
        print(currentLocation.coordinate.longitude)
        currentCoordinate = currentLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR: \(error.localizedDescription)")
    }
}
