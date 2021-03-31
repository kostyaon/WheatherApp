import Foundation

struct DailyWeather: Decodable {
    let date: Int
    let sunriseTime: Int
    let sunsetTime: Int
    let maxTemperature: Double
    let minTemperature: Double
    let weather: [Weather]
    var icon: String {
        weather.first!.icon
    }
    let probabilityOfPerception: Double
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case sunriseTime = "sunrise"
        case sunsetTime = "sunset"
        case temp
        case feels_like
        case pressure
        case humidity
        case dew_point
        case wind_speed
        case wind_deg
        case weather
        case clouds
        case probabilityOfPerception = "pop"
        case rain
        case uvi
    }
    
    enum TemperatureCodingKeys: String, CodingKey {
        case day
        case minTemperature = "min"
        case maxTemperature = "max"
        case night
        case eve
        case morn
    }
    
    enum WeatherCodingKeys: CodingKey {
        case id
        case main
        case description
        case icon
    }
    
    // MARK: - init(decoder)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Int.self, forKey: .date)
        sunriseTime = try container.decode(Int.self, forKey: .sunriseTime)
        sunsetTime = try container.decode(Int.self, forKey: .sunsetTime)
        probabilityOfPerception = try container.decode(Double.self, forKey: .probabilityOfPerception)
        weather = try container.decode([Weather].self, forKey: .weather)
        
        let temp = try container.nestedContainer(keyedBy: TemperatureCodingKeys.self, forKey: .temp)
        minTemperature = try temp.decode(Double.self, forKey: .minTemperature)
        maxTemperature = try temp.decode(Double.self, forKey: .maxTemperature)
    }
}
