//
//  PhotoViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    // MARK: - Private Property
    private let color = Color()
    private let cornerRadius = CornerRadius()
    private var animationView = LottieAnimationView()
    
    // MARK: - UI
    private var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 10
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
        setupAnimation()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstButton.backgroundColor = color.buttonColor
        secondButton.backgroundColor = color.buttonColor
        thirdButton.backgroundColor = color.buttonColor
    }
    
    // MARK: - Private Method
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named(Constants.lottieAnimation.rawValue)
        animationView.frame = CGRect(x: 0, y: 150, width: 50, height: 50)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        view.addSubview(animationView)
        animationView.play()
    }
    
    @objc private func infoPressed(){
        let alert = UIAlertController(
            title: AppConstants.infoButton,
            message: Constants.infoMessage.rawValue,
            preferredStyle: .actionSheet
        )
        
        let cancelAction = UIAlertAction(title: AppConstants.cancelButton, style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 40))
        let imageView = UIImageView(frame: titleView.bounds)
        imageView.image = UIImage(named: Constants.navigationImage.rawValue)
        imageView.contentMode = .scaleAspectFit
        titleView.addSubview(imageView)
        
        navigationItem.titleView = titleView
        
        let darkModeButtonImage = UIImage(systemName: Constants.darkModeItem.rawValue)
        let darkModeButton = UIBarButtonItem(image: darkModeButtonImage, style: .plain, target: self, action: #selector(darkModePressed))
        
        navigationItem.rightBarButtonItem = darkModeButton
        
        let infoImage = UIImage(systemName: AppConstants.infoItemIcon)
        let infoButton = UIBarButtonItem(image: infoImage, style: .plain, target: self, action: #selector(infoPressed))
        
        navigationController?.navigationBar.tintColor = AppConstants.navigationBarTintColor
        navigationItem.leftBarButtonItem = infoButton
    }
    
    @objc private func darkModePressed(){
        openSettingAction()
    }
    
    private func openSettingAction(){
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        } else {
            print(Constants.openSettingActionError.rawValue)
        }
    }
    
    private func setupViews() {
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(animationView)
        mainStackView.addArrangedSubview(firstButton)
        mainStackView.addArrangedSubview(secondButton)
        mainStackView.addArrangedSubview(thirdButton)
        
        firstButton.setTitle(Constants.firstButtonTitle.rawValue, for: .normal)
        firstButton.addTarget(self, action: #selector(todaysPictureButtonTapped), for: .touchUpInside)
        
        secondButton.setTitle(Constants.secondButtonTitle.rawValue, for: .normal)
        secondButton.addTarget(self, action: #selector(randomSetButtonTapped), for: .touchUpInside)
        
        thirdButton.setTitle(Constants.thirdButtonTitle.rawValue, for: .normal)
        thirdButton.addTarget(self, action: #selector(searchPictureButtonTapped), for: .touchUpInside)
        
        firstButton.layer.cornerRadius = CGFloat(cornerRadius.buttonCornerRadius)
        secondButton.layer.cornerRadius = CGFloat(cornerRadius.buttonCornerRadius)
        thirdButton.layer.cornerRadius = CGFloat(cornerRadius.buttonCornerRadius)
        
        view.backgroundColor = .systemBackground
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

// MARK: - Setup Constraints
extension HomeViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            firstButton.heightAnchor.constraint(equalToConstant: 40),
            
            secondButton.heightAnchor.constraint(equalToConstant: 40),
            
            thirdButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: - Constants
extension HomeViewController {
    private struct Color {
        let buttonColor = UIColor(red: 0.36, green: 0.58, blue: 0.99, alpha: 1.00)
    }
    private struct CornerRadius  {
        let buttonCornerRadius = 15
    }
    private enum Constants: String {
        case infoMessage = """
        Compatibility:
        iPhone iOS 15.0 or later.
        
        Age Rating:
        4+
        
        Languages:
        English
        
        Category:
        Reference
        
        Developer:
        Anastasiya Omak for Accenture
        
        Size:
        5.7 MB
        """
        case openSettingActionError = "Error: Invalid value UIApplication.openSettingsURLString"
        case firstButtonTitle = "Today's Picture"
        case secondButtonTitle = "Random Set"
        case thirdButtonTitle = "Search Picture"
        case lottieAnimation = "space"
        case navigationImage = "nasapng"
        case darkModeItem = "gearshape"
    }
}

