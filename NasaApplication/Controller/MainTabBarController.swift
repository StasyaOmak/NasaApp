//
//  MainTabBarController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        generateTabBar()
        setTabBarAppearance()
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: HomeViewController(), title: "Home", image: UIImage(systemName: "house")),
            generateVC(viewController: PhotoViewController(), title: "Photo", image: UIImage(systemName: "photo")),
            generateVC(viewController: AsteroidViewController(), title: "Asteroid", image: UIImage(systemName: "bolt")),
            generateVC(viewController: BookmarksViewController(), title: "Bookmark", image: UIImage(systemName: "bookmark")),
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.titlePositionAdjustment = .init(horizontal: -3, vertical: 0)
        
        return navigationController
    }
    
    
    private func setTabBarAppearance() {
        
        tabBar.tintColor = UIColor(red: 0.98, green: 0.26, blue: 0.23, alpha: 1.00)
        tabBar.unselectedItemTintColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
    }
}
