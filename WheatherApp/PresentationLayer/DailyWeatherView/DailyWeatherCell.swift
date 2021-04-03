import Foundation
import UIKit

class DailyWeatherCell: UITableViewCell {
    // MARK: - Views
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 30
        
        return stackView
    }()
    
    // MARK: - init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViews() {
        // Setup stackView
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    // MARK: - Helper methods
    public func setupDailyView(with weather: [DailyWeather]) {
        for day in weather {
            let dailyView = DailyView()
            dailyView.updateView(with: day)
            stackView.addArrangedSubview(dailyView)
        }
    }
    
}
