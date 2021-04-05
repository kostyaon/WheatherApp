import Foundation
import UIKit
import CoreLocation

class ViewController: UIViewController {
    // MARK: - Views methods
    override func loadView() {
        let mainScreen = MainScreenView()
        self.view = mainScreen
        self.view.backgroundColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationManager = LocationManager.shared
        locationManager.locationDelegate = self
        locationManager.startSearchingLocation()
        
       
    }
    
    // MARK: - Private methods
    private func updateWeatherResponse(latitude lat: Double, longitude long: Double) {
        WeatherAPIManager.fetch(type: WeatherResponse.self, router: WeatherRouter.fetchWeatherOneCall(lat, long, "minutely,alerts", AppEnvironment.apiKey)) { result in
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
}

// MARK: - Extensions
extension ViewController: CurrentLocationManagerDelegate {
    func updateCurrentCoordinate(with coordinate: (Double, Double)) {
        updateWeatherResponse(latitude: coordinate.0, longitude: coordinate.1)
        
    }
    
    func showLocationDeniedAlert(){
        let alert = UIAlertController(title: "Location Services Disabled", message: "Enable location services for 'WeatherApp' in Settings", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
