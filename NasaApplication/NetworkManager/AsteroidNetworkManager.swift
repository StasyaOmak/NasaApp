//
//  AsteroidNetworkManager.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 27/11/2023.
//

import Foundation

class AsteroidNetworkManager {
    static let apiKey = "1kDltXwD3QbkCzKTa9zQnjk7ep6J57SGegoDoF6Q"
    private let url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2023-12-01&end_date=2023-12-07&api_key=\(apiKey)"
    
    func fetchData(completion: @escaping (Result<[AsteroidModel], Error>) -> () ) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, err ) in
            
            guard err == nil else {
                completion(.failure(err!))
                return
            }

            guard let data = data else { return }
            
            do {
                let jsonData = try JSONDecoder().decode(AsteroidData.self, from: data)
                let model: [AsteroidModel] = jsonData.nearEarthObjects.values.flatMap{dict in
                    var result: [AsteroidModel] = []
                    dict.forEach{result.append(AsteroidModel(object: $0))}
                    
                    return result
                }
                completion(.success(model))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
}

