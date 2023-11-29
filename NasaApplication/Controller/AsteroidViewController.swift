//
//  AsteroidViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//


import UIKit

class AsteroidViewController: UIViewController {
    
    private var asteroids: [AsteroidModel] = []
    private let asteroidNetworkManager = AsteroidNetworkManager()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AsteroidTableViewCell.self, forCellReuseIdentifier: "AsteroidCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        asteroidNetworkManager.fetchData { [weak self] asteroid in
            DispatchQueue.main.async {
                self?.asteroids = asteroid
                self?.tableView.reloadData()
            }
        }
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
        
        
        return cell
    }
}

