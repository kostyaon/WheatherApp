import Foundation
import UIKit

class HourlyCell: UICollectionViewCell {
    // MARK: - Views
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Test"
        label.font = UIFont
            .preferredFont(forTextStyle: .headline)
            .withSize(10)
        label.textColor = .black
        label.backgroundColor = .red
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
        // Setup label
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
