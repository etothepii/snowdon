//
//  LatLon.swift
//  MapProgress
//
//  Created by James Robinson on 24/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class LatLon {
    
    private let lat: Double;
    private let lon: Double;
    
    init(latitude: Double, longitude: Double) {
        self.lat = latitude;
        self.lon = longitude;
    }
    
    func getLatitudeInDegrees() -> Double {
        return lat;
    }
    
    func getLatitudeInRadians() -> Double {
        return lat / 180 * M_PI;
    }
    
    func getLongitudeInDegrees() -> Double {
        return lon;
    }
    
    func getLongitudeInRadians() -> Double {
        return lon / 180 * M_PI;
    }
    
}