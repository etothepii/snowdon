//
//  RouteCalculator.swift
//  MapProgress
//
//  Created by James Robinson on 20/07/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class RouteCalculator {
    
    private var route: Route? = nil
    private var distance: [Double]? = nil
    private var altitude: [Double]? = nil
    private var index: Int? = nil
    
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
    
    func setLocation(osGrid: OSGrid) -> Int {
        getAltitude()
        getDistance()
        var points = route!.getPoints()
        var bestIndex = 0
        var bestDistance = points[0].osGrid.dSquared(osGrid)
        for currentIndex in 1...points.count - 1 {
            let distance = points[currentIndex].osGrid.dSquared(osGrid)
            if (distance < bestDistance) {
                bestDistance = distance
                bestIndex = currentIndex
            }
        }
        index = bestIndex
        return index!
    }
}
