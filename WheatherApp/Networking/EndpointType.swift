import Foundation

protocol EndpointType {
    var baseURL: String { get }
    var path: String { get }
    var parameters: String { get }
    var fullURL: URL { get }
}

