//
//  PhotoOfTheDayNetworkManager.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 29/11/2023.
//

import Foundation

class PhotoOfTheDayNetworkManager{
    
    private let url =
    "https://api.nasa.gov/planetary/apod?api_key=1kDltXwD3QbkCzKTa9zQnjk7ep6J57SGegoDoF6Q"
    
    func fetchData(completion: @escaping (AstronomyPicture) -> () ) {
        
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
                let jsonData = try JSONDecoder().decode(AstronomyPicture.self, from: data)
                completion(jsonData)
            }catch{
                print("err:::::", error)
            }
            
        }.resume()
        
    }
    
}


