import Foundation
import UIKit

struct WeatherAPIManager {
    static func fetch<T: Decodable>(type: T.Type, router: EndpointType, completion: @escaping (Result<T, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: router.fullURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                fatalError("\(response!)")
            }
            
            guard let result = data else {
                fatalError("Something wrong with data")
            }
            
            let jsonData = try! JSONDecoder().decode(type.self, from: result)
            completion(.success(jsonData))
        }
        
        dataTask.resume()
    }
    
    static func loadImage(router: EndpointType, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: router.fullURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                fatalError("\(response!)")
            }
            
            guard let result = data else {
                fatalError("Something wrong with data")
            }
            
            completion(.success(result))
        }
        
        dataTask.resume()
    }
}
