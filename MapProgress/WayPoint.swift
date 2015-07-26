//
//  WayPoint.swift
//  MapProgress
//
//  Created by James Robinson on 24/04/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class WayPoint {
    
    let osGrid: OSGrid;
    let altitude: Double;
    
    init(easting: Double, northing: Double, altitude:Double) {
        self.osGrid = OSGrid(easting: easting, northing: northing)
        self.altitude = altitude;
    }
    
}