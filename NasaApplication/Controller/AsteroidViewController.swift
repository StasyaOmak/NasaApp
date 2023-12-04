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
        navigationController?.navigationBar.tintColor = UIColor(red: 0.00, green: 0.24, blue: 0.57, alpha: 1.00)
        let titleLabel = UILabel()
            titleLabel.text = "Asteroid"
            titleLabel.textColor = UIColor.label
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            navigationItem.titleView = titleLabel
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .red
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(sender: )))
        view.addGestureRecognizer(longPressRecognizer)
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
    
    private func setupErrorAnimation() {
        animationView = LottieAnimationView(name: "error")
        animationView.frame = CGRect(x: (view.bounds.width - 200) / 2, y: (view.bounds.height - 200) / 2, width: 200, height: 200)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.3
        view.addSubview(animationView)
        animationView.play()
    }
    
    private func fetchAstronomyData() {
        let networkManager = AsteroidNetworkManager()
        networkManager.fetchData { [weak self] (result) in
            switch result {
            case .success(let success):
                self?.asteroids = success
                DispatchQueue.main.async {
                    
                    self?.sortAsteroids()
                    self?.animationView.stop()
                    self?.animationView.removeFromSuperview()
                    self?.tableView.reloadData()
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
    
    @objc private func longPressed(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint){
                
                asteroidInfoAlert(for: asteroids[indexPath.row])
                
            }
        }
    }
    
    private func asteroidInfoAlert (for asteroids: AsteroidModel) {
        let alert = UIAlertController(
            title: asteroids.name,
            message: "Absolute magnitude: \(asteroids.absoluteMagnitudeH)\n Sentry: \(asteroids.isSentryObject ? "Yes" : "No")",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
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

