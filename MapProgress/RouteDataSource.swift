//
//  RouteDataSource.swift
//  MapProgress
//
//  Created by James Robinson on 09/08/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class RouteDataSource: NSObject, CPTPlotDataSource {
    
    private let routeCalculator: RouteCalculator
    
    init(routeCalculator: RouteCalculator) {
        self.routeCalculator = routeCalculator
    }
    
    func numberOfRecordsForPlot(plot: CPTPlot!) -> UInt {
        return UInt(routeCalculator.getPoints())
    }
    
    func doubleForPlot(plot: CPTPlot!, field: UInt, recordIndex: UInt) -> Double {
        switch (field) {
            case 0:
                return Double(routeCalculator.getDistanceAt(Int(recordIndex)))
            default:
                return Double(routeCalculator.getAltitudeAt(Int(recordIndex)))
        }
    }
}