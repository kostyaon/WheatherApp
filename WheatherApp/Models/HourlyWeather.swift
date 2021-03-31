import Foundation

struct HourlyWeather: Decodable {
    let date: Int
    let temperature: Double
    let weather: [Weather]
    var icon: String {
        weather.first!.icon
    }
    let probabilityOfPerception: Double
    
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
        temperature = try container.decode(Double.self, forKey: .temperature)
        probabilityOfPerception = try container.decode(Double.self, forKey: .probabilityOfPerception)
        weather = try container.decode([Weather].self, forKey: .weather)
    }
}
