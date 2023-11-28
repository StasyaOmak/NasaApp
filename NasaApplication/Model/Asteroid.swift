//
//  Asteroid.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 27/11/2023.
//

import Foundation


// MARK: - Asteroid
struct AsteroidData: Codable {
    let elementCount: Int
    let nearEarthObjects: [String: [NearEarthObject]]

    enum CodingKeys: String, CodingKey {
        case elementCount = "element_count"
        case nearEarthObjects = "near_earth_objects"
    }
}

// MARK: - NearEarthObject
struct NearEarthObject: Codable {
    
    let name: String
    let estimatedDiameter: EstimatedDiameter
    let isPotentiallyHazardousAsteroid: Bool
    let closeApproachData: [CloseApproachDatum]
    

    enum CodingKeys: String, CodingKey {
        
        case name
        case estimatedDiameter = "estimated_diameter"
        case isPotentiallyHazardousAsteroid = "is_potentially_hazardous_asteroid"
        case closeApproachData = "close_approach_data"
        
    }
}

// MARK: - CloseApproachDatum
struct CloseApproachDatum: Codable {
    let closeApproachDateFull: String
    let orbitingBody: String

    enum CodingKeys: String, CodingKey {
        case closeApproachDateFull = "close_approach_date_full"
        case orbitingBody = "orbiting_body"
    }
}


// MARK: - EstimatedDiameter
struct EstimatedDiameter: Codable {
    let meters: Feet
}

// MARK: - Feet
struct Feet: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double

    enum CodingKeys: String, CodingKey {
        case estimatedDiameterMin = "estimated_diameter_min"
        case estimatedDiameterMax = "estimated_diameter_max"
    }
}
