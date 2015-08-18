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
    private var totalDistance: Double? = nil
    private var totalAltitude: Double? = nil
    private var minAltitude: Double? = nil
    private var maxAltitude: Double? = nil
    
    init() {}
    
    func setRoute(route: Route) {
        self.route = route;
        calculateDistance()
        calculateAltitude()
        index = 0
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
            distanceDelta = wayPoint.osGrid.d(previousOSGrid) / 1609.344;
            previousOSGrid = wayPoint.osGrid;
            totalDistance += distanceDelta;
            distance!.append(totalDistance);
        }
        self.totalDistance = totalDistance
    }
    
    private func calculateAltitude() {
        altitude = [Double]();
        var totalAltitude: Double = 0;
        var previousAltitude: Double? = nil;
        for wayPoint in route!.points {
            if (minAltitude == nil || wayPoint.altitude < minAltitude) {
                minAltitude = wayPoint.altitude
            }
            if (maxAltitude == nil || wayPoint.altitude > maxAltitude) {
                maxAltitude = wayPoint.altitude
            }
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
        self.totalAltitude = totalAltitude
    }
    
    func getAltitude() -> [Double] {
        return altitude!;
    }
    
    func getDistance() -> [Double] {
        return distance!;
    }
    
    func getAltitudeAt(index: Int) -> Double {
        return route!.points[index].altitude;
    }
    
    func getDistanceAt(index: Int) -> Double {
        return distance![index];
    }
    
    func getCurrentCummulativeAltitude() -> Double {
        return altitude![index!];
    }
    
    func getCurrentAltitude() -> Double {
        return route!.points[index!].altitude;
    }
    
    func getCurrentDistance() -> Double {
        return distance![index!];
    }
    
    func getTotalAltitude() -> Double {
        return totalAltitude!
    }
    
    func getMinAltitude() -> Double {
        return minAltitude!
    }
    
    func getMaxAltitude() -> Double {
        return maxAltitude!
    }
    
    func getTotalDistance() -> Double {
        return totalDistance!
    }
    
    private func calculateIndexFromSeq(viableIndecies: Range<Int>) -> Int {
        var bestIndex: Int? = nil
        var bestDistance = 0.01
        for currentIndex in viableIndecies {
            let distance = route!.getPoints()[currentIndex].osGrid.dSquared(location)
            if (bestIndex == nil || distance < bestDistance) {
                bestDistance = distance
                bestIndex = currentIndex
            }
        }
        return bestIndex!
    }
    
    private func getViableIndecies() -> Range<Int> {
        if (index == nil) {
            return 0...route!.getPoints().count - 1
        }
        else {
            return max(0, index! - 10)...min(index! + 10, route!.getPoints().count - 1)
        }
    }
    
    private func calculateIndex() {
        var newIndex = calculateIndexFromSeq(getViableIndecies())
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
        if (location != nil && location!.dSquared(osGrid) > 250000) {
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
