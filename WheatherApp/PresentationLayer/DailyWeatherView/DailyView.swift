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
        label.textColor = .white
        label.textAlignment = .left
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "icloud.fill")
        imageView.contentMode = .scaleAspectFit
        
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
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "53"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(18)
        label.textColor = .white
        label.textAlignment = .right
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "37"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(18)
        label.textColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.4)
        label.textAlignment = .right
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
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
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
           dayLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10)
        ])
        
        // Setup icon
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.bottomAnchor.constraint(equalTo: icon.topAnchor, constant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        // Setup predictionOfPerceptionLabel
        addSubview(predictionOfPerceptionLabel)
        NSLayoutConstraint.activate([
            predictionOfPerceptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 3),
            predictionOfPerceptionLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            predictionOfPerceptionLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        // Setup maxTemperatureLabel
        addSubview(maxTemperatureLabel)
        NSLayoutConstraint.activate([
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: predictionOfPerceptionLabel.trailingAnchor, constant: 45),
            maxTemperatureLabel.centerYAnchor.constraint(equalTo: predictionOfPerceptionLabel.centerYAnchor),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        // Setup minTemperatureLabel
        addSubview(minTemperatureLabel)
        NSLayoutConstraint.activate([
            minTemperatureLabel.centerYAnchor.constraint(equalTo: maxTemperatureLabel.centerYAnchor),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: maxTemperatureLabel.trailingAnchor, constant: 25),
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func loadIcon(name icon: String) {
        WeatherAPIManager.loadImage(router: WeatherRouter.fetchIcon(icon)) { result in
            switch result {
            case.failure(let error):
                fatalError("ERROR: \(error.localizedDescription)")
            case.success(let data):
                DispatchQueue.main.async {
                    self.icon.image = UIImage(data: data)
                }
            }
        }
    }
    
    // MARK: - Public methods
    public func updateView(with weather: DailyWeather) {
        loadIcon(name: weather.icon)
        dayLabel.text = weather.day
        weather.probabilityOfPerception == 0.0 ? (predictionOfPerceptionLabel.text = "") : (predictionOfPerceptionLabel.text = "\(weather.probabilityOfPerception.intFormat)%")
        maxTemperatureLabel.text = "\(weather.maxTemperature.intFormat)"
        minTemperatureLabel.text = "\(weather.minTemperature.intFormat)"
    }
}
