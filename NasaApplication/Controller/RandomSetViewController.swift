//
//  RandomSetViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 27/11/2023.
//


//import UIKit
//import SDWebImage
//import Lottie
//
//class RandomSetViewController: UIViewController {
//
//    
//    var astronomyPictures: [AstronomyPicture] = []
//    
//    let countItem = 2
//    let sectionInsert = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
//    
//    
//    
//
//    private let collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        
//        layout.minimumInteritemSpacing = 1
//        layout.minimumLineSpacing = 10
//        
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        collectionView.showsVerticalScrollIndicator = false
//        
//        
//        return collectionView
//    }()
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .systemBackground
//        
//        
//        setupCollectionView()
//        fetchAstronomyData()
//        setConstraints()
//    }
//
//    private func setupCollectionView() {
//        self.view.addSubview(collectionView)
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//    }
//
//    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//        ])
//    }
//
//    private func fetchAstronomyData() {
//        let networkManager = PhotoNetworkManager()
//        networkManager.fetchData(count: 70) { [weak self] (data) in
//            self?.astronomyPictures = data
////            self?.astronomyPictures.append(data)
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//            }
//        }
//    }
//}
//
//extension RandomSetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return astronomyPictures.count
//    }
//    
//    
//    
//    // настройка нашей фото ячейки
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = .black
//        
//        let imageView = UIImageView()
//        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        
//        cell.contentView.addSubview(imageView)
//        
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
//        ])
//        
//        
//        if let imageURL = URL(string: astronomyPictures[indexPath.item].url) {
//            imageView.sd_setImage(with: imageURL, completed: nil)
//        }
//        
//        return cell
//    }
//   
//    
////    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////           let selectedPhoto = astronomyPictures[indexPath.row]
////           let detailVC = RandomPhotoDetailViewController()
////           detailVC.setupViews(with: selectedPhoto)
////           navigationController?.pushViewController(detailVC, animated: true)
////       }
//}
//    
// 
//extension RandomSetViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let space = sectionInsert.left * CGFloat(countItem + 1)
//        let availableWidth = view.frame.width - space
//        let widthPerItem = availableWidth / CGFloat(countItem)
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        sectionInsert.left
//    }
//   
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        sectionInsert
//    }
//    
//    
//    
//}


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

    // Добавляем Lottie-вид
//    private let loadingAnimationView: LottieAnimation = {
//        let animationView = LottieAnimation.named("planet") // Замените на имя вашей Lottie-анимации
//        animationView.loopMode = .loop
//        animationView.contentMode = .scaleAspectFit
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        return animationView
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        view.addSubview(animationView) // Добавляем Lottie-вид на ваш контроллер
         // Запускаем анимацию
        
        setupCollectionView()
        setupAnimation()
        fetchAstronomyData()
        setConstraints()
        
        
    }
    
    private func setupAnimation() {
                animationView.animation = LottieAnimation.named("waiting")
        

        
        animationView.frame = CGRect(x: 0, y: 200, width: 400, height: 200)
//        animationView.center = view.
//        animationView.backgroundColor = .black
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
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
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func fetchAstronomyData() {
        let networkManager = PhotoNetworkManager()
        networkManager.fetchData(count: 70) { [weak self] (data) in
            self?.astronomyPictures = data

            DispatchQueue.main.async {
                self?.animationView.stop() // Останавливаем анимацию после загрузки данных
                self?.animationView.removeFromSuperview() // Убираем Lottie-вид из представления
                self?.collectionView.reloadData()
            }
        }
    }
}

extension RandomSetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return astronomyPictures.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .black
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
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
        
        return cell
    }
}

extension RandomSetViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let space = sectionInsert.left * CGFloat(countItem + 1)
        let availableWidth = view.frame.width - space
        let widthPerItem = availableWidth / CGFloat(countItem)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsert.left
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsert
    }
}
