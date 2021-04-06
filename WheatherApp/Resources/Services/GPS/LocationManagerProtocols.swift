import Foundation

protocol CurrentLocationManagerDelegate {
    func showLocationDeniedAlert()
    func updateCurrentCoordinate(with coordinate: (Double, Double))
}
