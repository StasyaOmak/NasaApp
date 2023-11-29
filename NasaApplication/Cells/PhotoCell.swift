//
//  PhotoCell.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 29/11/2023.
//

//import UIKit
//
//class PhotoCell: UICollectionViewCell {
//    
//    
//    
//     var imageView : UIImageView = {
//        let element = UIImageView()
//        
//        element.contentMode = .scaleAspectFill
//        element.clipsToBounds = true
//        
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
//    
//    override init(frame: CGRect) {
//            super.init(frame: frame)
//            setupUI()
//        }
//        
//        required init?(coder: NSCoder) {
//            super.init(coder: coder)
//            setupUI()
//        }
//        
//        private func setupUI() {
//            addSubview(imageView)
//            setupConstraints()
//        }
//        
//        private func setupConstraints() {
//            NSLayoutConstraint.activate([
//                imageView.topAnchor.constraint(equalTo: topAnchor),
//                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
//            ])
//        }
//    
//    static let identifier = "PhotoCell"
//    
//    }

