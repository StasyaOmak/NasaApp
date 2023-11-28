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
//        setupView()

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
        
     
       
        
        
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height),
            cornerRadius: height / 2
        )
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainBlack.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}