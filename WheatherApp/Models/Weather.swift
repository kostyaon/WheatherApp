import Foundation

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String
    
    // MARK: - init methods
    init(icon: String) {
        self.id = nil
        self.main = nil
        self.description = nil
        self.icon = icon
    }
}
