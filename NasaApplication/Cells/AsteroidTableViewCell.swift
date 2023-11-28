//
//  AsteroidTableViewCell.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 28/11/2023.
//



import UIKit


class AsteroidTableViewCell: UITableViewCell {
    
    
    var nameLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var diametrLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var aproachLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var orbitingLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var hazardousLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var distanceLabel: UILabel = {
        let element = UILabel()
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
    
    private func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(diametrLabel)
        contentView.addSubview(aproachLabel)
        contentView.addSubview(orbitingLabel)
        contentView.addSubview(hazardousLabel)
        contentView.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            diametrLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            diametrLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            aproachLabel.topAnchor.constraint(equalTo: diametrLabel.bottomAnchor, constant: 10),
            aproachLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            orbitingLabel.topAnchor.constraint(equalTo: aproachLabel.bottomAnchor, constant: 10),
            orbitingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            hazardousLabel.topAnchor.constraint(equalTo: orbitingLabel.bottomAnchor, constant: 10),
            hazardousLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            distanceLabel.topAnchor.constraint(equalTo: hazardousLabel.bottomAnchor, constant: 10),
            distanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            distanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
