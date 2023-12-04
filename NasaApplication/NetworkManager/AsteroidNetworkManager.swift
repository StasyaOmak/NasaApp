//
//  AsteroidNetworkManager.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 27/11/2023.
//

import Foundation


class AsteroidNetworkManager {
    
    static let shared = AsteroidNetworkManager()
    
    private let url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2023-11-26&end_date=2023-12-03&api_key=1kDltXwD3QbkCzKTa9zQnjk7ep6J57SGegoDoF6Q"
    
    func fetchData(completion: @escaping ([AsteroidModel]) -> () ) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, err ) in
            
            guard err == nil else {
                print("err:::::", err!)
                return
            }
            
            //print("response:", response as Any)
            
            guard let data = data else { return }
            
            
            do {
                let jsonData = try JSONDecoder().decode(AsteroidData.self, from: data)
                let model: [AsteroidModel] = jsonData.nearEarthObjects.values.flatMap{dict in
                    var result: [AsteroidModel] = []
                    dict.forEach{result.append(AsteroidModel(object: $0))}
                    return result
                }
                completion(model)
            }catch{
                print("err:::::", error)
            }
            
            
        }.resume()
        
    }
    
}

