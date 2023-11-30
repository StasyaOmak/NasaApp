//
//  TodaysPictureViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 26/11/2023.
//

import Foundation
import SDWebImage
import Lottie


class TodaysPictureViewController: UIViewController {
    
    private var photoOfTheDay: AstronomyPicture?
    private let photoNetworkManager = PhotoOfTheDayNetworkManager()
    var animationView = LottieAnimationView()
    
    
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
        element.textAlignment = .left
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 18, weight: .bold)
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let dayImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let titleLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 22, weight: .bold)
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let textLabel: UITextView = {
        let element = UITextView()
        element.textAlignment = .justified
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
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
    }()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonTapped))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        view.addSubview(animationView)
        
        scrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(dayImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(textLabel)
        
        setupNavigationBar()
        setupConstraints()
        setupAnimation()
        
        animationView.play()

        
        photoNetworkManager.fetchData { [weak self] picture in
            DispatchQueue.main.async {
                self?.photoOfTheDay = picture
                self?.setupViews()
                
                self?.animationView.stop()
                self?.animationView.removeFromSuperview()
                self?.view.setNeedsDisplay()
            }
        }
    }
    
    @objc private func addBarButtonTapped(){
        print("Hello")
    }
    
    @objc private func actionBarButtonTapped() {
        print("Hello")
        
        guard let image = dayImageView.image else {
            print("No image to share")
            return
        }
        
        let text = """
            Date: \(dateLabel.text ?? "")
            Title: \(titleLabel.text ?? "")
            Explanation: \(textLabel.text ?? "")
        """
        
        let objectsToShare: [Any] = [image, text]
        let shareController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, completed, _, error in
            if completed {
                print("Sharing succeeded")
            } else {
                print("Sharing failed: \(String(describing: error))")
            }
        }
        
        present(shareController, animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [actionBarButtonItem, addBarButtonItem]
        actionBarButtonItem.tintColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
        addBarButtonItem.tintColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
        //        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
        navigationController?.hidesBarsOnSwipe = true
        actionBarButtonItem.isEnabled = true
        addBarButtonItem.isEnabled = true
    }
    
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named("loadingBlue")
        animationView.frame = CGRect(x: (view.bounds.width - 200) / 2, y: (view.bounds.height - 200) / 2, width: 200, height: 200)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        view.addSubview(animationView)
        animationView.play()
    }
    
    private func setupViews() {
        dateLabel.text = photoOfTheDay?.date
        titleLabel.text = photoOfTheDay?.title
        textLabel.text = photoOfTheDay?.explanation
        
        guard let url = URL(string: photoOfTheDay?.url ?? "") else { return }
        dayImageView.sd_setImage(with: url)
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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
            
            textLabel.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

