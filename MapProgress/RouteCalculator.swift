//
//  RouteCalculator.swift
//  MapProgress
//
//  Created by James Robinson on 20/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class RouteCalculator {
    
    init() {}
    
    func getAltitude(route: Route) -> [Double] {
        var altitude = [Double]();
        for wayPoint in route.points {
            altitude.append(0);
        }
        return altitude;
    }
    
    func getDistance(route: Route) -> [Double] {
        var distance = [Double]();
        for wayPoint in route.points {
            distance.append(0);
        }
        return distance;
    }
}
