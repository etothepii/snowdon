//
//  LatLon.swift
//  MapProgress
//
//  Created by James Robinson on 24/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class LatLon {
    
    var lat: Double;
    var lon: Double;
    
    init() {
        self.lat = 0;
        self.lon = 0;
    }
    
    init(point: CartesianPoint, a: Double, b: Double) {
        
        let x = point.x;
        let y = point.y;
        let z = point.z;
        let e2 = (a*a-b*b) / (a*a); // 1st eccentricity squared
        let f2 = (a*a-b*b) / (b*b); // 2nd eccentricity squared Îµ2
        let p = sqrt(x*x + y*y); // distance from minor axis
        let R = sqrt(p*p + z*z); // polar radius
        
        //  φ = Î²; λ = Ï†; q = Î»; t = Î½
        
        // parametric latitude (Bowring eqn 17, replacing tanÎ² = zÂ·a / pÂ·b)
        let tanφ = (b*z)/(a*p) * (1+f2*b/R);
        let sinφ = tanφ / sqrt(1+tanφ*tanφ);
        let cosφ = sinφ / tanφ;
        
        // geodetic latitude (Bowring eqn 18)
        let λ = atan2(z + f2*b*sinφ*sinφ*sinφ, p - e2*a*cosφ*cosφ*cosφ);
        
        // longitude
        let q = atan2(y, x);
        
        self.lat = Translator.fromRadians(λ);
        self.lon = Translator.fromRadians(q);
    }
    
    init(latitude: Double, longitude: Double) {
        self.lat = latitude;
        self.lon = longitude;
    }
    
    func getLatitudeInDegrees() -> Double {
        return lat;
    }
    
    func getLatitudeInRadians() -> Double {
        return Translator.toRadians(lat);
    }
    
    func getLongitudeInDegrees() -> Double {
        return lon;
    }
    
    func getLongitudeInRadians() -> Double {
        return Translator.toRadians(lon)
    }
    
    func toCartesian() -> CartesianPoint {
        let φ = getLatitudeInRadians();
        let λ = getLongitudeInRadians();
        let a = getExcentrictyA();
        let b = getExcentrictyB();
        
        let sinφ = sin(φ);
        let cosφ = cos(φ);
        let sinλ = sin(λ);
        let cosλ = cos(λ);
        
        let e2 = (a*a - b*b) / (a*a);
        var q = a / sqrt(1 - e2*sinφ*sinφ);
        
        var x = q * cosφ * cosλ;
        var y = q * cosφ * sinλ;
        var z = (1-e2)*q * sinφ;
        
        return CartesianPoint(x: x, y: y, z: z)
    }
    
    func toOSGrid() -> OSGrid {
        preconditionFailure("This method must be overridden")
    }
    
    func getExcentrictyA() -> Double {
        preconditionFailure("This method must be overridden")
    }
    
    func getExcentrictyB() -> Double {
        preconditionFailure("This method must be overridden")
    }
    
}