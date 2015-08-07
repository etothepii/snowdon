//
//  RouteCalculator.swift
//  MapProgress
//
//  Created by James Robinson on 20/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class RouteCalculator {
    
    var route: Route? = nil
    var distance: [Double]? = nil;
    var altitude: [Double]? = nil;
    
    init() {}
    
    func setRoute(route: Route) {
        self.route = route;
        distance = nil;
        altitude = nil;
    }
    
    func getAltitude() -> [Double] {
        if (altitude == nil) {        altitude = [Double]();
            var totalAltitude: Double = 0;
            var previousAltitude: Double? = nil;
            for wayPoint in route!.points {
                var altitudeDelta: Double = 0;
                if (previousAltitude != nil) {
                    altitudeDelta = wayPoint.altitude - previousAltitude!;
                }
                previousAltitude = wayPoint.altitude;
                if (altitudeDelta > 0) {
                    totalAltitude += altitudeDelta;
                }
                altitude!.append(totalAltitude);
            }
        }
        return altitude!;
    }
    
    func getDistance() -> [Double] {
        if (distance == nil) {
            distance = [Double]();
            var totalDistance: Double = 0;
            var previousOSGrid: OSGrid?;
            var distanceDelta: Double = 0;
            for wayPoint in route!.points {
                distanceDelta = wayPoint.osGrid.d(previousOSGrid);
                previousOSGrid = wayPoint.osGrid;
                totalDistance += distanceDelta;
                distance!.append(totalDistance);
            }
        }
        return distance!;
    }
}
