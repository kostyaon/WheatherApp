import Foundation
import UIKit

class HourlyCell: UICollectionViewCell {
    // MARK: - Views
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "----"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(15)
        label.textColor = .white
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var predictionOfPerceptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "--"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(10)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "icloud")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "---"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(18)
        label.textColor = .white
        label.textAlignment = .center
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
        // Setup timeLabel
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // Setup predictionOfPerceptionLabel
        addSubview(predictionOfPerceptionLabel)
        NSLayoutConstraint.activate([
            predictionOfPerceptionLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2.0),
            predictionOfPerceptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // Setup icon
        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 12.0),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Setup temperatureLabel
        addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 13.0),
            temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
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
            weather.probabilityOfPerception?.rounded() == 0.0 ? (predictionOfPerceptionLabel.text = "") : (predictionOfPerceptionLabel.text = "\(weather.probabilityOfPerception!.intFormat)%")
        } else {
            timeLabel.text = weather.time
            temperatureLabel.text = weather.sunState
            predictionOfPerceptionLabel.text = ""
        }
    }
}
