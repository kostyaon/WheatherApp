import Foundation

class PersistanceManager {
    static func saveWeatherResponse(item: WeatherResponse) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(item)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error with encoding item: \(error.localizedDescription)")
        }
    }
    
    static func loadWeatherResponse() -> WeatherResponse? {
        var item: WeatherResponse?
        
        if let data = try? Data(contentsOf: dataFilePath()) {
            let decoder = JSONDecoder()
            
            do {
                item = try decoder.decode(WeatherResponse.self, from: data)
            } catch {
                print("Error with decoding item: \(error.localizedDescription)")
            }
        }
        
        return item
   }
    
    static func dataFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0].appendingPathComponent("WeatherApp.json")
    }
}
