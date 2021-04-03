import Foundation
import UIKit

class MainScreenView: UIView {
    // MARK: - Properties
    var currentWeather: CurrentWheather?
    var dailyWeather: [DailyWeather] = []
    var hourlyWeather: [HourlyWeather] = []
    
    // MARK: - Views
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "City"
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(50)
        label.textColor = .black
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(25)
        label.textColor = .black
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "58°"
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(80)
        label.textColor = .black
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    lazy var maxMinTempLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max. 80°, min. 43°"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(15)
        label.textColor = .black
        label.textAlignment = .center
        label.shadowOffset = CGSize(width: 0, height: -1.2)
        
        return label
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(ParameterCell.self, forCellReuseIdentifier: "parameterCell")
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: "dailyCell")
        
        return tableView
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
        // Setup cityLabel
        addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 120.0),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Setup descriptionLabel
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Setup currentTempLabel
        addSubview(currentTempLabel)
        NSLayoutConstraint.activate([
            currentTempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5.0),
            currentTempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            currentTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Setup maxMinTempLabel
        addSubview(maxMinTempLabel)
        NSLayoutConstraint.activate([
            maxMinTempLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 5.0),
            maxMinTempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            maxMinTempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Setup tableView
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: maxMinTempLabel.topAnchor, constant: 70.0),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func updateCurrentWeather() {
        descriptionLabel.text = currentWeather!.description.capitalized
        currentTempLabel.text = "\(currentWeather!.temperature.intFormat)°"
        maxMinTempLabel.text = "Max. \(dailyWeather.first!.maxTemperature.intFormat)°, min. \(dailyWeather.first!.minTemperature.intFormat)°"
    }
    
    // MARK: - Helper methods
    public func updateView(with weather: WeatherResponse) {
        self.hourlyWeather = weather.hourly48
        self.dailyWeather = weather.daily7
        self.currentWeather = weather.currentWeather
        updateCurrentWeather()
        tableView.reloadData()
    }
    
}

// MARK: - Extensions
extension MainScreenView: UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parameterCell") as! ParameterCell
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell") as! DailyWeatherCell
            return cell
        case 1...10:
            if let weather = currentWeather {
                cell.updateParameterCell(for: indexPath.row, with: weather)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "parameterCell") as! ParameterCell
            return cell
        }
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hourlyView = HourlyWeatherView()
        hourlyView.backgroundColor = .white
        
        return hourlyView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        default:
            return 55.0
        }
    }
}
