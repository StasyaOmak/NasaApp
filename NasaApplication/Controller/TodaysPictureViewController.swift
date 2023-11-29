//
//  TodaysPictureViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 26/11/2023.
//

import Foundation
import SDWebImage


class TodaysPictureViewController: UIViewController {
    
    
//    var myScrollView = UIScrollView()
    
    private var photoOfTheDay: AstronomyPicture?
    private let photoNetworkManager = PhotoNetworkManager()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 1
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    let dateLabel: UILabel = {
        let element = UILabel()
        element.text = "12-13-12"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 5, weight: .bold)
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
        element.text = "text"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 5, weight: .bold)
        element.minimumScaleFactor = 0.5
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let textLabel: UITextView = {
        let element = UITextView()
        element.textAlignment = .center
        element.text = "jnkdjbkfjabdkvjbndfjklbnkjvkfjdbjkvbdfkjbkvjdkfjbvkjbdfkjbvkjdfkjbkjfdbkjkdfjbkjfdkjbkjdfb"
        element.font = .systemFont(ofSize: 5, weight: .black)
        element.isEditable = false
       /* element.isScrollEnabled = true*/ 
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.contentSize = CGSize(width: 500, height: 1000)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scrollView.contentInsetAdjustmentBehavior = .never
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)
//        mainStackView.addArrangedSubview(scrollView)
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(dayImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(textLabel)
        
        
        setupConstraints()
        
        photoNetworkManager.fetchData { [weak self] picture in
            
            DispatchQueue.main.async {
                self?.photoOfTheDay = picture.first
                
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
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            
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
            
//            dateLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            
//            dateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            dateLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            
//            
//            dayImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 25),
//            dayImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            dayImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            dayImageView.heightAnchor.constraint(equalToConstant: 200),
//            dayImageView.widthAnchor.constraint(equalToConstant: 150),
//            
//            titleLabel.topAnchor.constraint(equalTo: dayImageView.bottomAnchor, constant: 25),
//            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            
//            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
//            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            textLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20) // Adjust constant as needed
        ])
        
        let contentHeight = dateLabel.frame.height + dayImageView.frame.height + titleLabel.frame.height + textLabel.frame.height + 200 // Adjust this value based on your content
            scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight)
    }
}

