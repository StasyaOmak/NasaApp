//
//  RandomSetViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 27/11/2023.
//



import UIKit
import SDWebImage
import Lottie


class RandomSetViewController: UIViewController {
    
    var astronomyPictures: [AstronomyPicture] = []
    var animationView = LottieAnimationView()
    
    let countItem = 2
    let sectionInsert = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(animationView)
        
        setupCollectionView()
        setupAnimation()
        fetchAstronomyData()
        setConstraints()
        
        navigationController?.navigationBar.tintColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
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
    
    private func setupErrorAnimation() {
        animationView = LottieAnimationView(name: "error")
        animationView.frame = CGRect(x: (view.bounds.width - 200) / 2, y: (view.bounds.height - 200) / 2, width: 200, height: 200)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.3
        view.addSubview(animationView)
        animationView.play()
    }
    
    private func setupCollectionView() {
        
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func fetchAstronomyData() {
        let networkManager = PhotoNetworkManager()
        networkManager.fetchData(count: 100 ) { [weak self] (result) in
            switch result {
            case .success(let success):
                self?.astronomyPictures = success
                DispatchQueue.main.async {
                    self?.animationView.stop()
                    self?.animationView.removeFromSuperview()
                    self?.collectionView.reloadData()
                }
                
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    self?.animationView.stop()
                    self?.animationView.removeFromSuperview()
                    self?.setupErrorAnimation()
                }
            }
        }
    }
}

extension RandomSetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return astronomyPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = astronomyPictures[indexPath.row]
        let detailVC = RandomPhotoDetailViewController()
        detailVC.selectedPhoto = item
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        cell.contentView.addSubview(imageView)
        
        cell.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
        ])
        
        if let imageURL = URL(string: astronomyPictures[indexPath.item].url) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        imageView.addGestureRecognizer(longPressGesture)
        imageView.isUserInteractionEnabled = true
        
        if let imageURL = URL(string: astronomyPictures[indexPath.item].url) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
        
        return cell
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let imageView = gesture.view as? UIImageView else { return }
        
        switch gesture.state {
        case .began:
            
            let zoomedImageView = UIImageView(image: imageView.image)
            zoomedImageView.contentMode = .scaleAspectFit
            zoomedImageView.backgroundColor = .black
            zoomedImageView.isUserInteractionEnabled = true
            
            if let window = self.view.window {
                zoomedImageView.frame = window.convert(imageView.frame, from: imageView.superview)
                window.addSubview(zoomedImageView)
            }
            
            UIView.animate(withDuration: 0.3) {
                zoomedImageView.frame = UIScreen.main.bounds
            }
            
            zoomedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomedImageViewTap(_:))))
            
        default:
            break
        }
    }
    
    @objc private func handleZoomedImageViewTap(_ gesture: UITapGestureRecognizer) {
        guard let zoomedImageView = gesture.view else { return }
        UIView.animate(withDuration: 0.3, animations: {
            zoomedImageView.alpha = 0
        }) { _ in
            zoomedImageView.removeFromSuperview()
        }
    }
    
}

private func handleZoomedImageViewTap(_ gesture: UITapGestureRecognizer) {
    guard let zoomedImageView = gesture.view else { return }
    UIView.animate(withDuration: 0.3, animations: {
        zoomedImageView.alpha = 0
    }) { _ in
        zoomedImageView.removeFromSuperview()
    }
}

extension RandomSetViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let space = sectionInsert.left * CGFloat(countItem + 1)
        let availableWidth = view.frame.width - space
        let widthPerItem = availableWidth / CGFloat(countItem)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsert.left
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsert
    }
}
