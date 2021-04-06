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
        label.textColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6)
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6:42 AM"
        label.numberOfLines = 0
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(22)
        label.textColor = .white
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)

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
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
        
        // Setup valueLabel
        addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            valueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1.5)
        ])
    }
    
    // MARK: - Public methods
    public func updateParameterCell(for row: Int, with weather: CurrentWheather) {
        switch row {
        case 1:
            nameLabel.text = " "
            valueLabel.font = UIFont
                .preferredFont(forTextStyle: .subheadline)
                .withSize(15)
            valueLabel.text = "Today: \(weather.description.lowercased()). The current temperature is \(weather.temperature.intFormat)°, feels like \(weather.feelsTemperature.intFormat)°. The wind speed: \(weather.windSpeed)m/s"
        case 2:
            nameLabel.text = "SUNRISE"
            valueLabel.text = weather.sunrise
        case 3:
            nameLabel.text = "SUNSET"
            valueLabel.text = weather.sunset
        case 4:
            nameLabel.text = "PROBABILITY OF PERCEPTION"
            if let pop = weather.probabilityOfPerception {
                valueLabel.text = "\(pop.intFormat)%"
            } else {
                valueLabel.text = "0%"
            }
        case 5:
            nameLabel.text = "HUMIDITY"
            valueLabel.text = "\(weather.humidity)%"
        case 6:
            nameLabel.text = "WIND"
            valueLabel.text = "\(weather.windDirection) \(weather.windSpeed)m/s"
        case 7:
            nameLabel.text = "FEELS LIKE"
            valueLabel.text = "\(weather.feelsTemperature.intFormat)°"
        case 8:
            nameLabel.text = "PERCEPTION"
            valueLabel.text = "0 mm"
        case 9:
            nameLabel.text = "PRESSURE"
            valueLabel.text = "\(weather.pressure) hPa"
        case 10:
            nameLabel.text = "VISIBILITY"
            valueLabel.text = "\(weather.visibilityMiles.twoDecimalsFormat) mi"
        case 11:
            nameLabel.text = "UV INDEX"
            valueLabel.text = "\(weather.uvIndex)"
        default:
            return
        }
    }
}
