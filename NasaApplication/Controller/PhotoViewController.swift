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
        element.spacing = 10
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var firstButton: UIButton = {
        let element = UIButton(type: .system)
        element.titleLabel?.font = .boldSystemFont(ofSize: 25)
        element.tintColor = .systemBackground
//        element.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        element.backgroundColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondButton: UIButton = {
        let element = UIButton(type: .system)
        element.titleLabel?.font = .boldSystemFont(ofSize: 25)
        element.tintColor = .systemBackground
//        element.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        element.backgroundColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
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
    
    private func setupAnimation() {
                animationView.animation = LottieAnimation.named("planet")
        

        
        animationView.frame = CGRect(x: 0, y: 150, width: 200, height: 200)

//        animationView.backgroundColor = .systemBackground
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.3
        view.addSubview(animationView)
        animationView.play()
        
    }
    
    private func setupUI() {
        
//        view.backgroundColor = .black
        
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(animationView)
        mainStackView.addArrangedSubview(firstButton)
        mainStackView.addArrangedSubview(secondButton)
        
        
        
        firstButton.setTitle("Today's Picture", for: .normal)
                firstButton.addTarget(self, action: #selector(todaysPictureButtonTapped), for: .touchUpInside)
        
        secondButton.setTitle("Random Set", for: .normal)
                secondButton.addTarget(self, action: #selector(randomSetButtonTapped), for: .touchUpInside)
        
        firstButton.layer.cornerRadius = 20
        secondButton.layer.cornerRadius = 20
        
    }
    
    @objc private func todaysPictureButtonTapped() {
        let todaysPictureViewController = TodaysPictureViewController()
        navigationController?.pushViewController(todaysPictureViewController, animated: true)
    }
    
    @objc private func randomSetButtonTapped() {
        let randomSetViewController = RandomSetViewController()
        navigationController?.pushViewController(randomSetViewController, animated: true)
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
        ])
    }
    
}
