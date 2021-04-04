import Foundation

struct HourlyWeather: Decodable {
    let date: TimeInterval
    var day: String {
        let date = Date(timeIntervalSince1970: self.date)
        
        let day = AppEnvironment.dateFormatter(from: date, to: .dayFormatter)
        
        return day
    }
    var hour: String {
        let date = Date(timeIntervalSince1970: self.date)

        let hour = AppEnvironment.dateFormatter(from: date, to: .hourFormatter)
        
        return hour
    }
    var time: String {
        let date = Date(timeIntervalSince1970: self.date)
        
        let time = AppEnvironment.dateFormatter(from: date, to: .timeFormatter)
        
        return time
    }
    var sunState: String?
    let temperature: Double?
    let weather: [Weather]
    var icon: String {
        weather.first!.icon
    }
    let probabilityOfPerception: Double?
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
        case feels_like
        case pressure
        case humidity
        case dew_point
        case uvi
        case clouds
        case visibility
        case wind_speed
        case wind_deg
        case wind_gust
        case weather
        case probabilityOfPerception = "pop"
        case rain
    }
    
    // MARK: - init(decoder) and others init
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(TimeInterval.self, forKey: .date)
        temperature = try container.decode(Double.self, forKey: .temperature)
        probabilityOfPerception = try container.decode(Double.self, forKey: .probabilityOfPerception)
        weather = try container.decode([Weather].self, forKey: .weather)
    }
    
    init(time: TimeInterval, sunState: String, icon: String) {
        self.date = time
        self.sunState = sunState
        self.temperature = nil
        self.weather = [Weather(icon: icon)]
        self.probabilityOfPerception = nil
    }
}
