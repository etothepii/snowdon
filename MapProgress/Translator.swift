//
//  Translator.swift
//  MapProgress
//
//  Created by James Robinson on 24/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class Translator {
    
    static func wgs84CartesianToOSGB36Caretsian(wgs84: CartesianPoint) -> CartesianPoint
    {
        let x = wgs84.x;
        let y = wgs84.y;
        let z = wgs84.z;
        
        let tx = -446.448;
        let ty =  125.157;
        let tz = -542.060;
        let rx =   -0.1502 / 3600 / 180 * M_PI;
        let ry =   -0.2470 / 3600 / 180 * M_PI;
        let rz =   -0.8421 / 3600 / 180 * M_PI;
        let s  =   1 + 20.4894 / 1e6;
        
        // apply transform
        let x2 = tx + x*s - y*rz + z*ry;
        let y2 = ty + x*rz + y*s - z*rx;
        let z2 = tz - x*ry + y*rx + z*s;
        
        return CartesianPoint(x: x2, y: y2, z: z2);
    }
    
    static func toRadians(value: Double) -> Double {
        return value / 180 * M_PI;
    }
    
    static func fromRadians(value: Double) -> Double {
        return value * 180 / M_PI;
    }
}