//
//  HomeViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//

import UIKit
import Lottie


class HomeViewController: UIViewController {

        var animationView = LottieAnimationView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupAnimation()
        view.backgroundColor = .systemBackground
        setupViews()
//        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        imageView.center = view.center
    }
    
    
    
    
    
    private func setupAnimation() {
                animationView.animation = LottieAnimation.named("nasaAnimationMain")
        

        animationView.frame = CGRect(x: (view.bounds.width - 400) / 2, y: (view.bounds.height - 200) / 2, width: 400, height: 200)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        view.addSubview(animationView)
        animationView.play()
        
    }
    
    
    private func setupViews() {
        createCustomNavigationBar()
        
        let settings = createCustomButton(
            imageName: "gearshape",
            selector: #selector(settingsRightButtonTapped)
            
        )
        
        let customTitleView = createCustomTitleView(
            labelName: "",
            imageNasa: "nasa"
        )
        
        navigationItem.rightBarButtonItems = [settings]
        navigationItem.titleView = customTitleView
    }
    
    @objc private func settingsRightButtonTapped() {
        openSettingAction()
        print("settingsRightButtonTapped")
    }
    private func openSettingAction(){
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        } else {
            print("Error: Invalid value UIApplication.openSettingsURLString")
        }
    }
}
    


