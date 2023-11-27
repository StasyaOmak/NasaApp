//
//  TodaysPictureViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 26/11/2023.
//

import Foundation
import SDWebImage


class TodaysPictureViewController: UIViewController {
    
    private var photoOfTheDay: AstronomyPicture?
    private let photoNetworkManager = PhotoNetworkManager()
    
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
        element.font = .systemFont(ofSize: 20, weight: .bold)
        element.minimumScaleFactor = 0.5
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let textLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.text = "jnkdjbkfjabdkvjbndfjklbnkjvkfjdbjkvbdfkjbkvjdkfjbvkjbdfkjbvkjdfkjbkjfdbkjkdfjbkjfdkjbkjdfb"
        element.font = .systemFont(ofSize: 20, weight: .black)
        element.minimumScaleFactor = 0.5
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var scrollView: UIScrollView = {
        let element = UIScrollView()
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(dayImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(textLabel)
        
        
        setupConstraints()
        
        photoNetworkManager.fetchData { [weak self] picture in
            
            DispatchQueue.main.async {
                self?.photoOfTheDay = picture
                
                self?.setupViews()
            }
        }
        
    }
    
    private func setupViews() {
        dateLabel.text = photoOfTheDay?.date
        titleLabel.text = photoOfTheDay?.title
        textLabel.text = photoOfTheDay?.explanation
        
        guard let url = URL(string: photoOfTheDay?.url ?? "N/A") else { return }
        dayImageView.sd_setImage(with: url)
        
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
            //            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //
            //            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            //            dayImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 25),
            //            dayImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            dayImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //            dayImageView.heightAnchor.constraint(equalToConstant: 200),
            //            dayImageView.widthAnchor.constraint(equalToConstant: 150),
            //
            //            titleLabel.topAnchor.constraint(equalTo: dayImageView.bottomAnchor, constant: 25),
            //            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //
            //            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            //            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            //            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            dateLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            
            dayImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 25),
            dayImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dayImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            dayImageView.heightAnchor.constraint(equalToConstant: 200),
            dayImageView.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: dayImageView.bottomAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
        
    }
}

