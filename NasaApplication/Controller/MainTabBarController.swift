//
//  MainTabBarController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Private Property
    private let titleBar = TitleBar()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setTabBarAppearance()
    }
    
    // MARK: - Private Method
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HomeViewController(), title: titleBar.homeTitle, image: UIImage(systemName: AppConstants.houseSysImage), selectedImage: UIImage(systemName: AppConstants.houseFillSysImage)),
            generateVC(viewController: AsteroidViewController(), title: titleBar.asteroidTitle, image: UIImage(systemName: AppConstants.boltSysImage), selectedImage: UIImage(systemName: AppConstants.boltFillSysImage)),
            generateVC(viewController: BookmarksViewController(), title: titleBar.bookmarkTitle, image: UIImage(systemName: AppConstants.bookmarkSysImage), selectedImage: UIImage(systemName: AppConstants.bookmarkFillSysImage)),
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage
        navigationController.tabBarItem.titlePositionAdjustment = .init(horizontal: -3, vertical: 0)
        
        return navigationController
    }
    
    private func setTabBarAppearance() {
        tabBar.tintColor = AppConstants.tabBarTintColor
        tabBar.unselectedItemTintColor = AppConstants.navigationBarTintColor
        tabBar.backgroundColor = .systemBackground
    }
}

// MARK: - Constants
extension MainTabBarController {
    private struct TitleBar {
        let homeTitle = "Home"
        let asteroidTitle = "Asteroid"
        let bookmarkTitle = "Bookmark"
    }
}
