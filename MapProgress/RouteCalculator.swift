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
    private var location: OSGrid? = nil
    
    init() {}
    
    func setRoute(route: Route) {
        self.route = route;
        calculateDistance()
        calculateAltitude()
        index = nil
        location = nil
    }
    
    func getPoints() -> Int {
        return distance!.count
    }
    
    private func calculateDistance() {
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
    
    private func calculateAltitude() {
        altitude = [Double]();
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
    
    func getAltitude() -> [Double] {
        return altitude!;
    }
    
    func getDistance() -> [Double] {
        return distance!;
    }
    
    func getAltitudeAt(index: Int) -> Double {
        return altitude![index];
    }
    
    func getDistanceAt(index: Int) -> Double {
        return distance![index];
    }
    
    func getCurrentAltitude() -> Double {
        return altitude![index!];
    }
    
    func getCurrentDistance() -> Double {
        return distance![index!];
    }
    
    private func calculateIndexFromSeq() -> Int{
        var bestIndex: Int? = nil
        var bestDistance = 0.01
        for currentIndex in 0...route!.getPoints().count - 1 {
            let distance = route!.getPoints()[currentIndex].osGrid.dSquared(location)
            if (bestIndex == nil || distance < bestDistance) {
                bestDistance = distance
                bestIndex = currentIndex
            }
        }
        return bestIndex!
    }
    
    private func calculateIndex() {
        var newIndex = calculateIndexFromSeq()
        if (index == nil) {
            index = newIndex
        }
        else if (newIndex < index) {
            index = index! - 1
        }
        else if (newIndex > index) {
            index = index! + 1
        }
    }
    
    func setLocation(osGrid: OSGrid) -> Int {
        if (location == nil || location!.dSquared(osGrid) > 250000) {
            index = nil
        }
        location = osGrid
        calculateIndex()
        return index!
    }
    
    func getIndex() -> Int? {
        return index;
    }
}
