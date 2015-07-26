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
    
    func toOSGB36() -> LatLon {
        return LatLon(latitude: 0, longitude: 0)
    }
    
    func toCartesian() -> CartesianPoint {
        let φ = getLatitudeInRadians();
        let λ = getLongitudeInRadians();
        let h: Double = 0; // height above ellipsoid - not currently used
        let a: Double = 6378137;
        let b = 6356752.31425;
        
        let sinφ = sin(φ);
        let cosφ = cos(φ);
        let sinλ = sin(λ);
        let cosλ = cos(λ);
        
        let e2 = (a*a - b*b) / (a*a);
        var q = a / sqrt(1 - e2*sinφ*sinφ);
        
        var x = (q+h) * cosφ * cosλ;
        var y = (q+h) * cosφ * sinλ;
        var z = ((1-e2)*q + h) * sinφ;
        
        return CartesianPoint(x: x, y: y, z: z)
    }
    
}