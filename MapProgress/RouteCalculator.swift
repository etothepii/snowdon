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
        var totalDistance: Double = 0;
        var previousNorthing: Double? = nil;
        var previousEasting: Double? = nil;
        var distanceDelta = 0;
        for wayPoint in route.points {
            var distanceDelta: Double = 0;
            if (previousNorthing != nil && previousEasting != nil ) {
                distanceDelta =
                    pow(
                        pow((wayPoint.northing - previousNorthing!), 2.0) +
                        pow((wayPoint.easting - previousEasting!), 2.0), 0.5);
            }
            previousNorthing = wayPoint.northing;
            previousEasting = wayPoint.easting;
            totalDistance += distanceDelta;
            distance.append(totalDistance);
        }
        return distance;
    }
}
