import Foundation

struct AppEnvironment {
    static let apiKey = "56892dee74a1f13dad4c6e624ea82e55"
    
    static func dateFormatter(from date: Date, to format: Formatter) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        
        let date = dateFormatter.string(from: date)
        
        return date
    }
}

enum Formatter: String {
    case dayFormatter = "cccc"
    case hourFormatter = "ha"
    case timeFormatter = "h:mma"
}

// MARK: - Extensions
extension Double {
    var intFormat: String {
        return String(format: "%.0f", self)
    }
    
    var twoDecimalsFormat: String {
        return String(format: "%.2f", self)
    }
}
