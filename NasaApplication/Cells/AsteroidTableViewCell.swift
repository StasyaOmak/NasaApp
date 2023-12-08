//
//  AsteroidTableViewCell.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 28/11/2023.
//



import UIKit

class AsteroidTableViewCell: UITableViewCell {
    // MARK: - UI
    private var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.alignment = .leading
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var diametStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var aproachStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var hazardousStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var missDistanceStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var nameLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var diametrLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var aproachLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var hazardousLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var missDistanceLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var diameterTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Diameter:"
        element.font = .systemFont(ofSize: 16, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var approachTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Closest Approach:"
        element.font = .systemFont(ofSize: 16, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var hazardousTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Dangerous:"
        element.font = .systemFont(ofSize: 16, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var missDistanceTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Miss Distance:"
        element.font = .systemFont(ofSize: 16, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Private Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func configure(model: AsteroidModel) {
        nameLabel.text = model.name
        diametrLabel.text = "\(model.diametrMinString) - \(model.diametrMaxString) meters"
        aproachLabel.text = model.closeApproachDate
        hazardousLabel.text = model.isDangeros ? "Yes" : "No"
        hazardousLabel.textColor = model.isDangeros ? .red : .label
        missDistanceLabel.text = "\(model.missDistanceString) km"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: model.closeApproachDate ) {
            dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            aproachLabel.text =  formattedDate
        }
    }
    
    private func setupViews() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(diametStackView)
        mainStackView.addArrangedSubview(aproachStackView)
        mainStackView.addArrangedSubview(hazardousStackView)
        mainStackView.addArrangedSubview(missDistanceStackView)
        
        
        diametStackView.addArrangedSubview(diameterTextLabel)
        diametStackView.addArrangedSubview(diametrLabel)
        
        aproachStackView.addArrangedSubview(approachTextLabel)
        aproachStackView.addArrangedSubview(aproachLabel)

        hazardousStackView.addArrangedSubview(hazardousTextLabel)
        hazardousStackView.addArrangedSubview(hazardousLabel)
        
        missDistanceStackView.addArrangedSubview(missDistanceTextLabel)
        missDistanceStackView.addArrangedSubview(missDistanceLabel)
    }
}

// MARK: - Setup Constraints
extension AsteroidTableViewCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
}
