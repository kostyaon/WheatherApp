import Foundation
import UIKit

class ParameterCell: UITableViewCell {
    // MARK: - Views
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SUNRISE"
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(15)
        label.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6:42 AM"
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(20)
        label.textColor = .black
        label.shadowOffset = CGSize(width: 0, height: -1.2)

        return label
    }()
    
    // MARK: - init(style: reuseIdentifier)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        // Setup nameLabel
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        // Setup valueLabel
        addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            valueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2.0)
        ])
    }
    
    // MARK: - Public methods
    public func updateParameterCell(for row: Int, with weather: CurrentWheather) {
        switch row {
        case 1:
            nameLabel.text = "Sunrise"
            valueLabel.text = weather.sunrise
        case 2:
            nameLabel.text = "Sunset"
            valueLabel.text = weather.sunset
        case 3:
            nameLabel.text = "Probability of precepetation"
            if let pop = weather.probabilityOfPerception {
                valueLabel.text = "\(pop.intFormat)%"
            } else {
                valueLabel.text = "0%"
            }
        case 4:
            nameLabel.text = "Humidity"
            valueLabel.text = "\(weather.humidity) %"
        case 5:
            nameLabel.text = "Wind"
            valueLabel.text = "\(weather.windDirection) \(weather.windSpeed)m/s"
        case 6:
            nameLabel.text = "Feels like"
            valueLabel.text = "\(weather.feelsTemperature.intFormat)°"
        case 7:
            nameLabel.text = "Pepception"
            valueLabel.text = "0 mm"
        case 8:
            nameLabel.text = "Pressure"
            valueLabel.text = "\(weather.pressure) hPa"
        case 9:
            nameLabel.text = "Visibility"
            valueLabel.text = "\(weather.visibilityMiles.twoDecimalsFormat) mi"
        case 10:
            nameLabel.text = "UV index"
            valueLabel.text = "\(weather.uvIndex)"
        default:
            return
        }
    }
}
