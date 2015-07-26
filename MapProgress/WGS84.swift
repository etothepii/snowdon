//
//  WGS84.swift
//  MapProgress
//
//  Created by James Robinson on 26/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class WGS84: LatLon {
    
    private let a: Double = 6378137;
    private let b = 6356752.31425;
    
    override init(latitude: Double, longitude: Double) {
        super.init(latitude: latitude, longitude: longitude)
    }
    
    init(point: CartesianPoint) {
        super.init(point: point, a: a, b: b);
    }
    
    override func getExcentrictyA() -> Double{
        return a;
    }
    
    override func getExcentrictyB() -> Double {
        return b;
    }
    
    override func toOSGrid() -> OSGrid {
        let wgs84Cart = toCartesian();
        let osgb36Cart = Translator.wgs84CartesianToOSGB36Caretsian(wgs84Cart);
        let osgb36 = OSGB36(point: osgb36Cart)
        return osgb36.toOSGrid();
    }
}
