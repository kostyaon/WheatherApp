import Foundation

enum WeatherRouter {
    case fetchWeatherOneCall(Double, Double, String, String)
    case fetchIcon(String)
    case fetchAirPolution(Double, Double, String)
}

// MARK: - Extensions
extension WeatherRouter: EndpointType {
    var baseURL: String {
        switch self {
        case .fetchWeatherOneCall, .fetchAirPolution:
            return "https://api.openweathermap.org/data/2.5"
        case .fetchIcon:
            return "http://openweathermap.org/img"
        }
    }
    
    var path: String {
        switch self {
        case .fetchWeatherOneCall:
            return "/onecall?"
        case .fetchIcon:
            return "/wn/"
        case .fetchAirPolution:
            return "/air_pollution?"
        }
    }
    
    var parameters: String {
        switch self {
        case .fetchWeatherOneCall(let latitude, let longitude, let exclude, let apiKey):
            return "lat=\(latitude)&lon=\(longitude)&exclude=\(exclude)&appid=\(apiKey)&units=metric"
            
        case .fetchIcon(let icon):
            return "\(icon)@2x.png"
        case .fetchAirPolution(let latitude, let longitude, let apiKey):
            return "lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        }
    }
    
    var fullURL: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path + self.parameters)!
        }
    }
}

