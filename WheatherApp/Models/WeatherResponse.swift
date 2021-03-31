import Foundation

struct WeatherResponse: Decodable {
    let currentWeather: CurrentWheather
    let hourly48: [HourlyWeather]
    let daily7: [DailyWeather]
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezone_offset
        case currentWeather = "current"
        case hourly48 = "hourly"
        case daily7 = "daily"
    }
    
    // MARK: - init(decoder)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentWeather = try container.decode(CurrentWheather.self, forKey: .currentWeather)
        hourly48 = try container.decode([HourlyWeather].self, forKey: .hourly48)
        daily7 = try container.decode([DailyWeather].self, forKey: .daily7)
    }
}

