//
//  Extension.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//

import UIKit

extension UIViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.22, green: 0.67, blue: 0.91, alpha: 1.00)
    }
    
    func createCustomTitleView(labelName: String, imageNasa: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
        
        let imageNasa = UIImageView()
        imageNasa.image = UIImage(named: "nasa")
        imageNasa.layer.cornerRadius = imageNasa.frame.height / 2
        imageNasa.frame = CGRect(x: -35, y: 0, width: 45, height: 40)
        view.addSubview(imageNasa)
        
        let labelName = UILabel()
//        labelName.text = "NASA"
//        labelName.tintColor = .white ???
        labelName.frame = CGRect(x: 120, y: 15, width: 220, height: 20)
        labelName.font = UIFont.systemFont(ofSize: 20)
        labelName.font = .systemFont(ofSize: 20, weight: .bold)
        view.addSubview(labelName)
        
        
        return view
    }
    
        func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
            
            let button = UIButton(type: .system)
            button.setImage(
                UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
                for: .normal
            )
            button.tintColor = UIColor(red: 0.22, green: 0.67, blue: 0.91, alpha: 1.00)
            button.imageView?.contentMode = .scaleAspectFit
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.addTarget(self, action: selector, for: .touchUpInside)
            
            let menuBarItem = UIBarButtonItem(customView: button)
            return menuBarItem
        }
    }

