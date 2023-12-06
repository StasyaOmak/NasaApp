//
//  AsteroidTableViewCell.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 28/11/2023.
//



import UIKit

class AsteroidTableViewCell: UITableViewCell {
    private var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.alignment = .leading
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
//    private var labelStackView: UIStackView = {
//        let element = UIStackView()
//        element.axis = .vertical
//        element.distribution = .fill
//        element.spacing = 10
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
//    private var labelStackViewTwo: UIStackView = {
//        let element = UIStackView()
//        element.axis = .horizontal
//        element.distribution = .fill
//        element.spacing = 10
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
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
   
    private var orbitingStackView: UIStackView = {
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
    
    private var nameLabel: UILabel = {
        let element = UILabel()
//        element.textAlignment = .center
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
    
    private var orbitingLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var hazardousLabel: UILabel = {
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
    
    private var orbitingTextLabel: UILabel = {
        let element = UILabel()
        element.text = "Orbiting Body:"
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func configure(model: AsteroidModel) {
        nameLabel.text = model.name
        diametrLabel.text = "\(model.diametrMinString) - \(model.diametrMaxString) meters"
        aproachLabel.text = model.closeApproachDate
        orbitingLabel.text = model.orbitingbody
        hazardousLabel.text = model.isDangeros ? "Yes" : "No"
        hazardousLabel.textColor = model.isDangeros ? .red : .label
    }
    
    private func setupSubviews() {
        
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(diametStackView)
        mainStackView.addArrangedSubview(aproachStackView)
        mainStackView.addArrangedSubview(orbitingStackView)
        mainStackView.addArrangedSubview(hazardousStackView)
        
        diametStackView.addArrangedSubview(diameterTextLabel)
        diametStackView.addArrangedSubview(diametrLabel)
        
        aproachStackView.addArrangedSubview(approachTextLabel)
        aproachStackView.addArrangedSubview(aproachLabel)
        
        orbitingStackView.addArrangedSubview(orbitingTextLabel)
        orbitingStackView.addArrangedSubview(orbitingLabel)
        
        hazardousStackView.addArrangedSubview(hazardousTextLabel)
        hazardousStackView.addArrangedSubview(hazardousLabel)
//
//
//        mainStackView.addArrangedSubview(labelStackViewX)
//        mainStackView.addArrangedSubview(labelStackViewY)
//        labelStackViewY.addArrangedSubview(nameLabel)
//        labelStackViewX.addArrangedSubview(labelStackView)
//        labelStackViewX.addArrangedSubview(labelStackViewTwo)
        
//        labelStackView.addArrangedSubview(diameterTextLabel)
//        labelStackView.addArrangedSubview(approachTextLabel)
//        labelStackView.addArrangedSubview(orbitingTextLabel)
//        labelStackView.addArrangedSubview(hazardousTextLabel)
//        
////        mainStackView.addArrangedSubview(labelStackViewTwo)
//        
//        labelStackViewTwo.addArrangedSubview(diametrLabel)
//        labelStackViewTwo.addArrangedSubview(aproachLabel)
//        labelStackViewTwo.addArrangedSubview(orbitingLabel)
//        labelStackViewTwo.addArrangedSubview(hazardousLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
            
//            labelStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5),
//            labelStackViewTwo.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5),
        ])
    }
}
