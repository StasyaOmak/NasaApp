//
//  PhotoViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//

import UIKit
import Lottie

class PhotoViewController: UIViewController {
    
    var animationView = LottieAnimationView()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 20
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var firstButton: UIButton = {
        let element = UIButton(type: .system)
        element.titleLabel?.font = .boldSystemFont(ofSize: 20)
        element.tintColor = .white
        element.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        element.tag = 1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondButton: UIButton = {
        let element = UIButton(type: .system)
        element.titleLabel?.font = .boldSystemFont(ofSize: 20)
        element.tintColor = .white
        element.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        element.tag = 1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var thirdButton: UIButton = {
        let element = UIButton(type: .system)
        element.titleLabel?.font = .boldSystemFont(ofSize: 20)
        element.tintColor = .white
        element.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        element.tag = 1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupAnimation()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstButton.backgroundColor = UIColor(red: 0.36, green: 0.58, blue: 0.99, alpha: 1.00)
        secondButton.backgroundColor = UIColor(red: 0.36, green: 0.58, blue: 0.99, alpha: 1.00)
        thirdButton.backgroundColor = UIColor(red: 0.36, green: 0.58, blue: 0.99, alpha: 1.00)
    }
    
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named("space")
        animationView.frame = CGRect(x: 0, y: 150, width: 50, height: 50)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        view.addSubview(animationView)
        animationView.play()
        
    }
    
    private func setupUI() {
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(animationView)
        mainStackView.addArrangedSubview(firstButton)
        mainStackView.addArrangedSubview(secondButton)
        mainStackView.addArrangedSubview(thirdButton)
        
        firstButton.setTitle("Today's Picture", for: .normal)
        firstButton.addTarget(self, action: #selector(todaysPictureButtonTapped), for: .touchUpInside)
        
        secondButton.setTitle("Random Set", for: .normal)
        secondButton.addTarget(self, action: #selector(randomSetButtonTapped), for: .touchUpInside)
        
        thirdButton.setTitle("Search Picture", for: .normal)
        thirdButton.addTarget(self, action: #selector(searchPictureButtonTapped), for: .touchUpInside)
        
        firstButton.layer.cornerRadius = 20
        secondButton.layer.cornerRadius = 20
        thirdButton.layer.cornerRadius = 20
        
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let alpha: CGFloat = (sender.tag == 1) ? 0.5 : 1.0
        sender.backgroundColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: alpha)
    }
    
    @objc private func todaysPictureButtonTapped() {
        let todaysPictureViewController = TodaysPictureViewController()
        navigationController?.pushViewController(todaysPictureViewController, animated: true)
    }
    
    @objc private func randomSetButtonTapped() {
        let randomSetViewController = RandomSetViewController()
        navigationController?.pushViewController(randomSetViewController, animated: true)
    }
    
    @objc private func searchPictureButtonTapped() {
        let searchPictureViewController = SearchPictureViewController()
        navigationController?.pushViewController(searchPictureViewController, animated: true)
    }
}

extension PhotoViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            
            firstButton.heightAnchor.constraint(equalToConstant: 80),
            
            secondButton.heightAnchor.constraint(equalToConstant: 80),
            
            thirdButton.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}
