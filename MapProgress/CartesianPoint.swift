//
//  CartesianPoint.swift
//  MapProgress
//
//  Created by James Robinson on 26/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class CartesianPoint {
    
    let x: Double;
    let y: Double;
    let z: Double;
    
    init(x: Double, y: Double, z: Double) {
        self.x = x;
        self.y = y;
        self.z = z;
    }
    
    func toOSGB36() -> CartesianPoint {
        
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
        
        var point = CartesianPoint(x: x2, y: y2, z: z2);
        
        return point;
    }
}