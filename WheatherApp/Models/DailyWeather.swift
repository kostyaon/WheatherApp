import Foundation

struct DailyWeather: Codable {
    let date: TimeInterval
    var day: String {
        let date = Date(timeIntervalSince1970: self.date)
        
        let day = AppEnvironment.dateFormatter(from: date, to: .dayFormatter)
        
        return day
    }
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
    
    // MARK: - init(decoder)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(TimeInterval.self, forKey: .date)
        sunriseTime = try container.decode(TimeInterval.self, forKey: .sunriseTime)
        sunsetTime = try container.decode(TimeInterval.self, forKey: .sunsetTime)
        probabilityOfPerception = try container.decode(Double.self, forKey: .probabilityOfPerception) * 100
        weather = try container.decode([Weather].self, forKey: .weather)
        
        let temp = try container.nestedContainer(keyedBy: TemperatureCodingKeys.self, forKey: .temp)
        minTemperature = try temp.decode(Double.self, forKey: .minTemperature)
        maxTemperature = try temp.decode(Double.self, forKey: .maxTemperature)
    }
    
    // MARK: - Encoder implementation
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(sunriseTime, forKey: .sunriseTime)
        try container.encode(sunsetTime, forKey: .sunsetTime)
        try container.encode(weather, forKey: .weather)
        try container.encode(probabilityOfPerception, forKey: .probabilityOfPerception)
        
        var temp = container.nestedContainer(keyedBy: TemperatureCodingKeys.self, forKey: .temp)
        try temp.encode(minTemperature, forKey: .minTemperature)
        try temp.encode(maxTemperature, forKey: .maxTemperature)
    }
}
