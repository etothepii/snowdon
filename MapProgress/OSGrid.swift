//
//  OSGrid.swift
//  MapProgress
//
//  Created by James Robinson on 24/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class OSGrid {
    
    let northing: Double
    let easting: Double
    
    init(easting: Double, northing: Double) {
        self.northing = northing;
        self.easting = easting;
    }
    
    func d(other: OSGrid?) -> Double {
        if (other == nil) {
            return 0;
        }
        return pow(
            pow((other!.northing - northing), 2.0) +
            pow((other!.easting - easting), 2.0), 0.5);
    }
}