import Foundation
import UIKit

class HourlyWeatherView: UIView {
    // MARK: - Properties
    var hourlyWeather: [HourlyWeather]?
    
    // MARK: - Views
    lazy var topBorder: UIView = {
        let border = UIView()
        
        border.translatesAutoresizingMaskIntoConstraints = false
        
        border.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        
        return border
    }()
    
    lazy var bottomBorder: UIView = {
        let border = UIView()
        
        border.translatesAutoresizingMaskIntoConstraints = false
        
        border.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        
        return border
    }()
    
    lazy var collectionFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionFlowLayout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(HourlyCell.self, forCellWithReuseIdentifier: "hourlyCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
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
        // Setup collectionView
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // Setup topBorder
        addSubview(topBorder)
        NSLayoutConstraint.activate([
            topBorder.topAnchor.constraint(equalTo: collectionView.topAnchor),
            topBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topBorder.bottomAnchor.constraint(equalTo: topBorder.topAnchor, constant: 1.0)
        ])
        
        // Setup topBorder
        addSubview(bottomBorder)
        NSLayoutConstraint.activate([
            bottomBorder.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -1),
            bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
    
    private func dateToHour(to date: Date?) -> String {
        let hour = AppEnvironment.dateFormatter(from: date ?? Date(), to: .hourFormatter)
        return hour
    }
    
    // MARK: - Helper methos
    public func updateView(with weather: [HourlyWeather]) {
        hourlyWeather = weather
        
        collectionView.reloadData()
    }
}

// MARK: - Extensions
extension HourlyWeatherView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let weather = hourlyWeather else {
            return 12
        }
        
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyCell
        
        if let weather = hourlyWeather {
            cell.updateHourlyCell(with: weather[indexPath.row])
        }
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsInRow: CGFloat = 7.0
        let padding: CGFloat = 10.0
        
        let itemWidth = (collectionView.bounds.width / itemsInRow) - padding
        let itemHeight: CGFloat = 110
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
