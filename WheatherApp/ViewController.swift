import Foundation
import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var weather: WeatherResponse?
    
    override func loadView() {
        let mainScreen = MainScreenView()
        self.view = mainScreen
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WeatherAPIManager.fetch(type: WeatherResponse.self, router: WeatherRouter.fetchWeatherOneCall(33.441792, -94.037689, "minutely,alerts", AppEnvironment.apiKey)) { result in
            switch result {
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            case .success(let response):
                self.weather = response
            }
        }
    }
}
