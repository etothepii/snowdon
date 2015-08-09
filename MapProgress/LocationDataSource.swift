//
//  LocationDataSource.swift
//  MapProgress
//
//  Created by James Robinson on 09/08/2015.
//  Copyright (c) 2015 James Robinson. All rights reserved.
//

import Foundation

class LocationDataSource: NSObject, CPTPlotDataSource {
    
    private let routeCalculator: RouteCalculator
    
    init(routeCalculator: RouteCalculator) {
        self.routeCalculator = routeCalculator
    }
    
    func numberOfRecordsForPlot(plot: CPTPlot!) -> UInt {
        if (routeCalculator.getIndex() == nil) {
            return UInt(0)
        }
        else {
            return UInt(1)
        }
    }
    
    func doubleForPlot(plot: CPTPlot!, field: UInt, recordIndex: UInt) -> Double {
        switch (field) {
            case 0:
                return Double(routeCalculator.getCurrentDistance())
            default:
                return Double(routeCalculator.getCurrentAltitude())
        }
    }
}