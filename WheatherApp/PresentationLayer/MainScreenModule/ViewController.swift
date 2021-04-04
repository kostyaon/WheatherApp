import Foundation
import UIKit

class ViewController: UIViewController {
    override func loadView() {
        let mainScreen = MainScreenView()
        self.view = mainScreen
        self.view.backgroundColor = UIColor(red: 0, green: 164, blue: 255, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        WeatherAPIManager.fetch(type: WeatherResponse.self, router: WeatherRouter.fetchWeatherOneCall(53.9006, 27.5590, "minutely,alerts", AppEnvironment.apiKey)) { result in
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
