import Foundation
import UIKit

class MainScreenView: UIView {
    // MARK: - Properties
    var currentWeather: CurrentWheather?
    var dailyWeather: [DailyWeather]?
    var hourlyWeather: [HourlyWeather] = []
    var oldContentOffset = CGPoint.zero
    
    // MARK: - Views
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "----"
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(50)
        label.textColor = .white
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(25)
        label.textColor = .white
        label.textAlignment = .center

        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var currentTempLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "58°"
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(80)
        label.textColor = .white
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    lazy var maxMinTempLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max. 80°, min. 43°"
        label.font = UIFont
            .preferredFont(forTextStyle: .subheadline)
            .withSize(15)
        label.textColor = .white
        label.textAlignment = .center
        label.shadowColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1)
        label.shadowOffset = CGSize(width: 1, height: 1.2)
        
        return label
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        
        tableView.register(ParameterCell.self, forCellReuseIdentifier: "parameterCell")
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: "dailyCell")
        
        return tableView
    }()
    
    // MARK: - Constraints
    var cityTopConstraint: NSLayoutConstraint?
    var tableViewTopConstraint: NSLayoutConstraint?
    let cityTopConstraintRange = (CGFloat(84)...CGFloat(160))
    let tableViewTopConstraintRange = (CGFloat(-80)...CGFloat(70))
    
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
        cityTopConstraint = cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 150)
        NSLayoutConstraint.activate([
            cityTopConstraint!,
            cityLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        // Setup descriptionLabel
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 3.0),
            descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        // Setup currentTempLabel
        addSubview(currentTempLabel)
        NSLayoutConstraint.activate([
            currentTempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5.0),
            currentTempLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        // Setup maxMinTempLabel
        addSubview(maxMinTempLabel)
        NSLayoutConstraint.activate([
            maxMinTempLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 5.0),
            maxMinTempLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        // Setup tableView
        addSubview(tableView)
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: maxMinTempLabel.topAnchor, constant: 70.0)
        NSLayoutConstraint.activate([
            tableViewTopConstraint!,
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func updateCurrentWeather(latitude lat: Double, longitude long: Double) {
        LocationManager.shared.reverseGeocoding(latitude: lat, longitude: long) { [weak self] (placemark, error) in
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Reverse geocoding error: \(error!.localizedDescription)")
                return
            }
            
            guard placemark!.count > 0 else {
                print("Reverse geocoding has problem with data!")
                return
            }
            
            if let place = placemark {
                weakSelf.cityLabel.text = place.first!.locality ?? "----"
            } else {
                weakSelf.cityLabel.text = "----"
            }
        }
        descriptionLabel.text = currentWeather!.description.capitalized
        currentTempLabel.text = "\(currentWeather!.temperature.intFormat)°"
        maxMinTempLabel.text = "Max. \(dailyWeather!.first!.maxTemperature.intFormat)°, min. \(dailyWeather!.first!.minTemperature.intFormat)°"
    }
    
    private func addSunriseSunsetInHourlyWeather(from dailyWeather: [DailyWeather]) -> [HourlyWeather] {
        var weather: [HourlyWeather] = []
        
        weather.append(HourlyWeather(time: dailyWeather[0].sunsetTime, sunState: "Sunset", icon: "50d"))
        weather.append(HourlyWeather(time: dailyWeather[0].sunriseTime, sunState: "Sunrise", icon: "02d"))
        weather.append(HourlyWeather(time: dailyWeather[1].sunsetTime, sunState: "Sunset", icon: "50d"))
        weather.append(HourlyWeather(time: dailyWeather[1].sunriseTime, sunState: "Sunrise", icon: "02d"))
        
        return weather
    }
    
    private func animateBigDelta(constraint: NSLayoutConstraint, views: [UIView]?, alphaForViews alpha: CGFloat?, bound: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveLinear], animations: {
            constraint.constant = bound
            if let views = views, let alpha = alpha {
                views.forEach {
                    $0.alpha = alpha
                }
            }
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    // MARK: - Helper methods
    public func updateView(with weather: WeatherResponse) {
        self.currentWeather = weather.currentWeather
        self.dailyWeather = weather.daily7
        
        currentWeather!.probabilityOfPerception = dailyWeather![0].probabilityOfPerception
        
        let array = addSunriseSunsetInHourlyWeather(from: [dailyWeather![0], dailyWeather![1]])
        for index in 0...11 {
            self.hourlyWeather.append(weather.hourly48[index])
            for el in array {
                if weather.hourly48[index].hour == el.hour && weather.hourly48[index].day == el.day {
                    self.hourlyWeather.append(el)
                }
            }
        }

        updateCurrentWeather(latitude: weather.latitude!, longitude: weather.longitude!)
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
        cell.tintColor = .white
        cell.separatorInset = UIEdgeInsets(top: 0.0, left: 20, bottom: 0.0, right: 20)
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell") as! DailyWeatherCell
            cell.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            if let weather = dailyWeather {
                cell.setupDailyView(with: weather)
            }
            return cell
        case 1:
            cell.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            if let weather = currentWeather {
                cell.updateParameterCell(for: indexPath.row, with: weather)
            }
            return cell
        case 2...11:
            if let weather = currentWeather {
                cell.updateParameterCell(for: indexPath.row, with: weather)
            }
            return cell
        default:
            return cell
        }
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hourlyView = HourlyWeatherView()
        hourlyView.backgroundColor = .black
        hourlyView.updateView(with: hourlyWeather)
        
        return hourlyView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250.0
        case 1:
            return 88.0
        default:
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let delta = scrollView.contentOffset.y - oldContentOffset.y
        let cityDelta = cityTopConstraint!.constant - delta
        let tableViewDelta = tableViewTopConstraint!.constant - delta*2
        
        // Finger scrolls up
        if (scrollView.contentOffset.y > 0 && delta > 0 && cityTopConstraint!.constant >= cityTopConstraintRange.lowerBound) {
            // Animate current weather description block
            if cityDelta < cityTopConstraintRange.lowerBound {
                //animateBigDelta(constraint: cityTopConstraint!, views: [currentTempLabel, maxMinTempLabel], alphaForViews: 0.0, bound: cityTopConstraintRange.lowerBound)
                cityTopConstraint!.constant = cityTopConstraintRange.lowerBound
                currentTempLabel.alpha = 0.0
                maxMinTempLabel.alpha  = 0.0
            } else {
                cityTopConstraint!.constant -= delta
                currentTempLabel.alpha -= delta/100
                maxMinTempLabel.alpha -= delta/100
                
                scrollView.contentOffset.y -= delta
            }
    
            // Animate tableView
            if tableViewDelta < tableViewTopConstraintRange.lowerBound {
                //animateBigDelta(constraint: tableViewTopConstraint!, views: nil, alphaForViews: nil, bound: tableViewTopConstraintRange.lowerBound)
                tableViewTopConstraint?.constant = tableViewTopConstraintRange.lowerBound
            } else {
                tableViewTopConstraint!.constant -= delta*2
            }
        }
        
        // Finger scrolls down
        if scrollView.contentOffset.y < 0 && delta < 0 && cityTopConstraint!.constant <= cityTopConstraintRange.upperBound {
            // Animate current weather description block
            if cityDelta > cityTopConstraintRange.upperBound {
                animateBigDelta(constraint: cityTopConstraint!, views: [currentTempLabel, maxMinTempLabel], alphaForViews: 1.0, bound: cityTopConstraintRange.upperBound)
            } else {
                cityTopConstraint!.constant -= delta
                currentTempLabel.alpha -= delta/100
                maxMinTempLabel.alpha -= delta/100
            }
            
            // Animate tableView
            if tableViewDelta > tableViewTopConstraintRange.upperBound {
                animateBigDelta(constraint: tableViewTopConstraint!, views: nil, alphaForViews: nil, bound: tableViewTopConstraintRange.upperBound)
            } else {
                tableViewTopConstraint!.constant -= delta*2
            }
        }
        
        oldContentOffset = scrollView.contentOffset
    }
}
