//
//  RandomPhotoDetailViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 29/11/2023.
//





import UIKit
import SDWebImage

class RandomPhotoDetailViewController: UIViewController {

    
    var selectedPhoto: AstronomyPicture?
    private let photoNetworkManager = PhotoNetworkManager()

    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 1
        element.distribution = .fill
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let dateLabel: UILabel = {
        let element = UILabel()
        element.text = "12-13-12"
        element.textAlignment = .left
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 18, weight: .bold)
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
        element.font = .systemFont(ofSize: 22, weight: .bold)
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let textLabel: UITextView = {
        let element = UITextView()
        element.textAlignment = .justified
        element.text = "jnkdjbkfjabdkvjbndfjklbnkjvkfjdbjkvbdfkjbkvjdkfjbvkjbdfkjbvkjdfkjbkjfdbkjkdfjbkjfdkjbkjdfb"
        element.font = .systemFont(ofSize: 14, weight: .bold)
        element.isEditable = false
    
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
        scrollView.addSubview(mainStackView)

        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(dayImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(textLabel)
        
        
        setupConstraints()
        
        photoNetworkManager.fetchData { [weak self] picture in
            DispatchQueue.main.async {
                self?.selectedPhoto = picture.last
                self?.setupViews()
            }
        }
        
    }
    
    private func setupViews() {
        dateLabel.text = selectedPhoto?.date
        titleLabel.text = selectedPhoto?.title
        textLabel.text = selectedPhoto?.explanation
        
        guard let url = URL(string: selectedPhoto?.url ?? "") else { return }
        dayImageView.sd_setImage(with: url)
        
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            
            dayImageView.heightAnchor.constraint(equalToConstant: 280),
            dayImageView.widthAnchor.constraint(equalToConstant: 250),
            dayImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            dayImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            dayImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 5),
            
            
            
            
            textLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
        
    }
}
