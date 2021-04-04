import Foundation
import UIKit

class HourlyCell: UICollectionViewCell {
    // MARK: - Views
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9pm"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(15)
        label.textColor = .black
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var predictionOfPerceptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "60%"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(10)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "icloud.fill")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "83°"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(18)
        label.textColor = .black
        label.textAlignment = .center
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
        // Setup timeLabel
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Setup predictionOfPerceptionLabel
        addSubview(predictionOfPerceptionLabel)
        NSLayoutConstraint.activate([
            predictionOfPerceptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 1.0),
            predictionOfPerceptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            predictionOfPerceptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Setup icon
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: predictionOfPerceptionLabel.bottomAnchor, constant: 10.0),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.bottomAnchor.constraint(equalTo: icon.topAnchor, constant: 40),
            icon.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        // Setup temperatureLabel
        addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 13.0),
            temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
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
    
    // MARK: - Helper methods
    public func updateHourlyCell(with weather: HourlyWeather) {
        loadIcon(name: weather.icon)
        
        if let temp = weather.temperature {
            timeLabel.text = weather.hour
            temperatureLabel.text = "\(temp.intFormat)°"
            weather.probabilityOfPerception == 0.0 ? (predictionOfPerceptionLabel.text = "") : (predictionOfPerceptionLabel.text = "\(weather.probabilityOfPerception!.intFormat)%")
        } else {
            timeLabel.text = weather.time
            temperatureLabel.text = weather.sunState
            predictionOfPerceptionLabel.text = ""
        }
    }
}
