//
//  TodaysPictureViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 26/11/2023.
//

import Foundation
import SDWebImage


class TodaysPictureViewController: UIViewController {
    
    
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 10
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    let dateLabel: UILabel = {
        let element = UILabel()
        element.text = "12-13-12"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 30, weight: .bold)
        element.minimumScaleFactor = 0.5
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let dayImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "nasa")
        element.contentMode = .scaleAspectFit
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let titleLabel: UILabel = {
        let element = UILabel()
        element.text = "Звезда такая-то"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 30, weight: .bold)
        element.minimumScaleFactor = 0.5
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let textLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.text = "jnkdjbkfjabdkvjbndfjklbnkjvkfjdbjkvbdfkjbkvjdkfjbvkjbdfkjbvkjdfkjbkjfdbkjkdfjbkjfdkjbkjdfb"
        element.font = .systemFont(ofSize: 30, weight: .bold)
        element.minimumScaleFactor = 0.5
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(dateLabel)
        view.addSubview(dayImageView)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        
        setupConstraints()
        
    }
    private func setupConstraints() {
        
            NSLayoutConstraint.activate([
                
                dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                
                dayImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 25),
                dayImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                dayImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                dayImageView.heightAnchor.constraint(equalToConstant: 200),
                dayImageView.widthAnchor.constraint(equalToConstant: 150),
                
                titleLabel.topAnchor.constraint(equalTo: dayImageView.bottomAnchor, constant: 25),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
                textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }
    }

