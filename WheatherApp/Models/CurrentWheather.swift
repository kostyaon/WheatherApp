import Foundation

struct CurrentWheather: Decodable {
    let sunriseTime: TimeInterval
    var sunrise: String {
        let date = Date(timeIntervalSince1970: self.sunriseTime)
        
        let time = AppEnvironment.dateFormatter(from: date, to: .timeFormatter)
        
        return time
    }
    let sunsetTime: TimeInterval
    var sunset: String {
        let date = Date(timeIntervalSince1970: self.sunsetTime)
        
        let time = AppEnvironment.dateFormatter(from: date, to: .timeFormatter)
        
        return time
    }
    let temperature: Double
    let feelsTemperature: Double
    let pressure: Int
    let humidity: Int
    let uvIndex: Double
    let visibilityMeters: Double
    var visibilityMiles: Double {
        visibilityMeters / 1609.34
    }
    let windSpeed: Double
    let windDegree: Double
    var windDirection: String {
        switch windDegree {
        case 11.25...33.75:
            return "nne"
        case 33.76...56.25:
            return "ne"
        case 56.26...78.75:
            return "ene"
        case 78.76...101.25:
            return "e"
        case 101.26...123.75:
            return "ese"
        case 123.76...146.25:
            return "se"
        case 146.26...168.75:
            return "sse"
        case 168.76...191.25:
            return "s"
        case 191.26...213.75:
            return "ssw"
        case 213.76...236.25:
            return "sw"
        case 236.26...258.75:
            return "wsw"
        case 258.76...281.25:
            return "w"
        case 281.26...303.75:
            return "wnw"
        case 303.76...326.25:
            return "nw"
        case 326.26...348.75:
            return "nnw"
        default:
            return "n"
        }
    }
    let weather: [Weather]
    var description: String {
        weather.first!.description
    }
    var icon: String {
        weather.first!.icon
    }
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case dt
        case sunriseTime = "sunrise"
        case sunsetTime = "sunset"
        case temperature = "temp"
        case feelsTemperature = "feels_like"
        case pressure
        case humidity
        case dew_point
        case uvIndex = "uvi"
        case clouds
        case visibilityMeters = "visibility"
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case weather
    }
    
    // MARK: - init(decoder)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        sunriseTime = try container.decode(TimeInterval.self, forKey: .sunriseTime)
        sunsetTime = try container.decode(TimeInterval.self, forKey: .sunsetTime)
        temperature = try container.decode(Double.self, forKey: .temperature)
        feelsTemperature = try container.decode(Double.self, forKey: .feelsTemperature)
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
        uvIndex = try container.decode(Double.self, forKey: .uvIndex)
        visibilityMeters = try container.decode(Double.self, forKey: .visibilityMeters)
        windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        windDegree = try container.decode(Double.self, forKey: .windDegree)
        weather = try container.decode([Weather].self, forKey: .weather)
    }
}
