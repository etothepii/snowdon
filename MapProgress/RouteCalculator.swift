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
        var totalAltitude: Double = 0;
        var previousAltitude: Double? = nil;
        for wayPoint in route.points {
            var altitudeDelta: Double = 0;
            if (previousAltitude != nil) {
                altitudeDelta = wayPoint.altitude - previousAltitude!;
            }
            previousAltitude = wayPoint.altitude;
            if (altitudeDelta > 0) {
                totalAltitude += altitudeDelta;
            }
            altitude.append(totalAltitude);
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
