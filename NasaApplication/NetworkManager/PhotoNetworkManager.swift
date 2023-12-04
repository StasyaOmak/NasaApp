//
//  PhotoNetworkManager.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 26/11/2023.
//

import Foundation
import Lottie
import UIKit

class PhotoNetworkManager{
    
   private var url =
    "https://api.nasa.gov/planetary/apod?api_key=1kDltXwD3QbkCzKTa9zQnjk7ep6J57SGegoDoF6Q"
    
    func fetchData(count: Int = 1, completion: @escaping (Result<[AstronomyPicture], Error>) -> () ) {
        url += "&count=\(count)"
        print(url)
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
                let jsonData = try JSONDecoder().decode([AstronomyPicture].self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
}



