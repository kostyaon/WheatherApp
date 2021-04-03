import Foundation
import UIKit

class DailyView: UIView {
    // MARK: - Views
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Monday"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(17)
        label.textColor = .black
        label.textAlignment = .left
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "icloud.fill")
        
        return imageView
    }()
    
    lazy var predictionOfPerceptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "33%"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(10)
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "53"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(18)
        label.textColor = .black
        label.textAlignment = .right
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "37"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(18)
        label.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        label.textAlignment = .right
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    // MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        // Setup dayLabel
        addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
           dayLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10)
        ])
        
        // Setup icon
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        // Setup predictionOfPerceptionLabel
        addSubview(predictionOfPerceptionLabel)
        NSLayoutConstraint.activate([
            predictionOfPerceptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 3),
            predictionOfPerceptionLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
        ])
        
        // Setup maxTemperatureLabel
        addSubview(maxTemperatureLabel)
        NSLayoutConstraint.activate([
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: predictionOfPerceptionLabel.trailingAnchor, constant: 45)
        ])
        
        // Setup minTemperatureLabel
        addSubview(minTemperatureLabel)
        NSLayoutConstraint.activate([
            minTemperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor, constant: 25)
        ])
    }
    
    // MARK: - Public methods
    public func updateView(with weather: DailyWeather) {
        dayLabel.text = weather.day
        predictionOfPerceptionLabel.text = ("\(weather.probabilityOfPerception)%")
        maxTemperatureLabel.text = "\(weather.maxTemperature)"
        minTemperatureLabel.text = "\(weather.minTemperature)"
    }
}
