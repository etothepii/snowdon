//
//  WayPoint.swift
//  MapProgress
//
//  Created by James Robinson on 24/04/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class WayPoint {
    
    var northing: Double;
    var easting: Double;
    var altitude: Double;
    
    init(northing: Double, easting: Double, altitude:Double) {
        self.northing = northing;
        self.easting = easting;
        self.altitude = altitude;
    }
    
}