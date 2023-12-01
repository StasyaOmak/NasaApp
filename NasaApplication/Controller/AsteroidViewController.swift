//
//  AsteroidViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//


import UIKit
import Lottie



class AsteroidViewController: UIViewController {
    
    
    private var asteroids: [AsteroidModel] = []
    private let asteroidNetworkManager = AsteroidNetworkManager()
    
    private var isSortingDangerousFirst = true
    
    var animationView = LottieAnimationView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AsteroidTableViewCell.self, forCellReuseIdentifier: "AsteroidCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        setupAnimation()
        
        fetchAstronomyData()
        setConstraints()
        
        let sortButtonImage = UIImage(systemName: "chevron.up.chevron.down")
        let sortButton = UIBarButtonItem(image: sortButtonImage, style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.rightBarButtonItem = sortButton
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
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
    
    private func fetchAstronomyData() {
        
        asteroidNetworkManager.fetchData { [weak self] asteroids in
            DispatchQueue.main.async {
                self?.asteroids = asteroids
                self?.sortAsteroids()
                self?.animationView.stop()
                self?.animationView.removeFromSuperview()
                self?.tableView.reloadData()
            }
        }
    }
    
    func sortAsteroids() {
        if isSortingDangerousFirst {
            asteroids.sort { $0.isDangeros && !$1.isDangeros }
        } else {
            asteroids.sort { !$0.isDangeros && $1.isDangeros }
        }
        isSortingDangerousFirst.toggle()
    }
    
    @objc func sortButtonTapped() {
        sortAsteroids()
        tableView.reloadData()
    }
    
}

extension AsteroidViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidCell", for: indexPath) as? AsteroidTableViewCell else {
            return UITableViewCell()
        }
        
        let asteroid = asteroids[indexPath.row]
        
        cell.nameLabel.text = asteroid.name
        cell.diametrLabel.text = "Diameter: \(asteroid.diametrMinString) - \(asteroid.diametrMaxString) meters"
        cell.aproachLabel.text = "Closest Approach: \(asteroid.closeApproachDate)"
        cell.orbitingLabel.text = "Orbiting Body: \(asteroid.orbitingbody)"
        cell.hazardousLabel.text = "Dangerous: \(asteroid.isDangeros ? "Yes" : "No")"
        
        cell.hazardousLabel.textColor = asteroid.isDangeros ? .red : .label

        return cell
    }
}

