import Foundation

struct WeatherResponse: Codable {
    let latitude: Double?
    let longitude: Double?
    let currentWeather: CurrentWheather
    let hourly48: [HourlyWeather]
    let daily7: [DailyWeather]
    
    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case timezone
        case timezone_offset
        case currentWeather = "current"
        case hourly48 = "hourly"
        case daily7 = "daily"
    }
    
    // MARK: - init(decoder)
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        currentWeather = try container.decode(CurrentWheather.self, forKey: .currentWeather)
        hourly48 = try container.decode([HourlyWeather].self, forKey: .hourly48)
        daily7 = try container.decode([DailyWeather].self, forKey: .daily7)
    }
    
    // MARK: - Encoder implementation
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(currentWeather, forKey: .currentWeather)
        try container.encode(hourly48, forKey: .hourly48)
        try container.encode(daily7, forKey: .daily7)
    }
}

