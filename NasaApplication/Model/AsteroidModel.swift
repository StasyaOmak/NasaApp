//
//  AsteroidModel.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 28/11/2023.
//

import Foundation

struct AsteroidModel {
    
    let name: String
    let isDangeros: Bool
    let closeApproachDate: String
    let orbitingbody: String
    let diameterMin: Double
    let diameterMax: Double
    let absoluteMagnitudeH: Double
    let isSentryObject: Bool
    let missDistance: String
    
    var diametrMinString: String {
        return String(format: "%.0f", diameterMin)
    }
    var diametrMaxString: String {
        return String(format: "%.0f", diameterMax)
        
    }

    init(object: NearEarthObject) {
        self.name = object.name
        self.isDangeros = object.isPotentiallyHazardousAsteroid
        self.closeApproachDate = object.closeApproachData.first?.closeApproachDateFull ?? ""
        self.orbitingbody = object.closeApproachData.first?.orbitingBody ?? ""
        self.diameterMin = object.estimatedDiameter.meters.estimatedDiameterMin
        self.diameterMax = object.estimatedDiameter.meters.estimatedDiameterMax
        self.absoluteMagnitudeH = object.absoluteMagnitudeH
        self.isSentryObject = object.isSentryObject
        self.missDistance = object.closeApproachData.first?.missDistance.kilometers ?? ""
    }
}

